//===----------------------- Dispatch.h -------------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
/// \file
///
/// This file implements classes that are used to model register files,
/// reorder buffers and the hardware dispatch logic.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_TOOLS_LLVM_MCA_DISPATCH_H
#define LLVM_TOOLS_LLVM_MCA_DISPATCH_H

#include "Instruction.h"
#include "RetireControlUnit.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include <map>

namespace mca {

class WriteState;
class DispatchUnit;
class Scheduler;
class Backend;

/// Manages hardware register files, and tracks data dependencies
/// between registers.
class RegisterFile {
  const llvm::MCRegisterInfo &MRI;

  // Each register file is described by an instance of RegisterMappingTracker.
  // RegisterMappingTracker tracks the number of register mappings dynamically
  // allocated during the execution.
  struct RegisterMappingTracker {
    // Total number of register mappings that are available for register
    // renaming. A value of zero for this field means: this register file has
    // an unbounded number of registers.
    const unsigned TotalMappings;
    // Number of mappings that are currently in use.
    unsigned NumUsedMappings;

    RegisterMappingTracker(unsigned NumMappings)
        : TotalMappings(NumMappings), NumUsedMappings(0) {}
  };

  // This is where information related to the various register files is kept.
  // This set always contains at least one register file at index #0. That
  // register file "sees" all the physical registers declared by the target, and
  // (by default) it allows an unbounded number of mappings.
  // Users can limit the number of mappings that can be created by register file
  // #0 through the command line flag `-register-file-size`.
  llvm::SmallVector<RegisterMappingTracker, 4> RegisterFiles;

  // This pair is used to identify the owner of a physical register, as well as
  // the cost of using that register file.
  using IndexPlusCostPairTy = std::pair<unsigned, unsigned>;

  // RegisterMapping objects are mainly used to track physical register
  // definitions. A WriteState object describes a register definition, and it is
  // used to track RAW dependencies (see Instruction.h).  A RegisterMapping
  // object also specifies the set of register files.  The mapping between
  // physreg and register files is done using a "register file mask".
  //
  // A register file index identifies a user defined register file.
  // There is one index per RegisterMappingTracker, and index #0 is reserved to
  // the default unified register file.
  //
  // This implementation does not allow overlapping register files. The only
  // register file that is allowed to overlap with other register files is
  // register file #0.
  using RegisterMapping = std::pair<WriteState *, IndexPlusCostPairTy>;

  // This map contains one entry for each physical register defined by the
  // processor scheduling model.
  std::vector<RegisterMapping> RegisterMappings;

  // This method creates a new RegisterMappingTracker for a register file that
  // contains all the physical registers specified by the register classes in
  // the 'RegisterClasses' set.
  //
  // The long term goal is to let scheduling models optionally describe register
  // files via tablegen definitions. This is still a work in progress.
  // For example, here is how a tablegen definition for a x86 FP register file
  // that features AVX might look like:
  //
  //    def FPRegisterFile : RegisterFile<[VR128RegClass, VR256RegClass], 60>
  //
  // Here FPRegisterFile contains all the registers defined by register class
  // VR128RegClass and VR256RegClass. FPRegisterFile implements 60
  // registers which can be used for register renaming purpose.
  //
  // The list of register classes is then converted by the tablegen backend into
  // a list of register class indices. That list, along with the number of
  // available mappings, is then used to create a new RegisterMappingTracker.
  void
  addRegisterFile(llvm::ArrayRef<llvm::MCRegisterCostEntry> RegisterClasses,
                  unsigned NumPhysRegs);

  // Allocates register mappings in register file specified by the
  // IndexPlusCostPairTy object. This method is called from addRegisterMapping.
  void createNewMappings(IndexPlusCostPairTy IPC,
                         llvm::MutableArrayRef<unsigned> UsedPhysRegs);

  // Removes a previously allocated mapping from the register file referenced
  // by the IndexPlusCostPairTy object. This method is called from
  // invalidateRegisterMapping.
  void removeMappings(IndexPlusCostPairTy IPC,
                      llvm::MutableArrayRef<unsigned> FreedPhysRegs);

  // Create an instance of RegisterMappingTracker for every register file
  // specified by the processor model.
  // If no register file is specified, then this method creates a single
  // register file with an unbounded number of registers.
  void initialize(const llvm::MCSchedModel &SM, unsigned NumRegs);

public:
  RegisterFile(const llvm::MCSchedModel &SM, const llvm::MCRegisterInfo &mri,
               unsigned NumRegs = 0)
      : MRI(mri), RegisterMappings(mri.getNumRegs(), {nullptr, {0, 0}}) {
    initialize(SM, NumRegs);
  }

  // Creates a new register mapping for RegID.
  // This reserves a microarchitectural register in every register file that
  // contains RegID.
  void addRegisterMapping(WriteState &WS,
                          llvm::MutableArrayRef<unsigned> UsedPhysRegs);

  // Invalidates register mappings associated to the input WriteState object.
  // This releases previously allocated mappings for the physical register
  // associated to the WriteState.
  void invalidateRegisterMapping(const WriteState &WS,
                                 llvm::MutableArrayRef<unsigned> FreedPhysRegs);

  // Checks if there are enough microarchitectural registers in the register
  // files.  Returns a "response mask" where each bit is the response from a
  // RegisterMappingTracker.
  // For example: if all register files are available, then the response mask
  // is a bitmask of all zeroes. If Instead register file #1 is not available,
  // then the response mask is 0b10.
  unsigned isAvailable(llvm::ArrayRef<unsigned> Regs) const;
  void collectWrites(llvm::SmallVectorImpl<WriteState *> &Writes,
                     unsigned RegID) const;
  void updateOnRead(ReadState &RS, unsigned RegID);

  unsigned getNumRegisterFiles() const { return RegisterFiles.size(); }

#ifndef NDEBUG
  void dump() const;
#endif
};

// Implements the hardware dispatch logic.
//
// This class is responsible for the dispatch stage, in which instructions are
// dispatched in groups to the Scheduler.  An instruction can be dispatched if
// functional units are available.
// To be more specific, an instruction can be dispatched to the Scheduler if:
//  1) There are enough entries in the reorder buffer (implemented by class
//     RetireControlUnit) to accomodate all opcodes.
//  2) There are enough temporaries to rename output register operands.
//  3) There are enough entries available in the used buffered resource(s).
//
// The number of micro opcodes that can be dispatched in one cycle is limited by
// the value of field 'DispatchWidth'. A "dynamic dispatch stall" occurs when
// processor resources are not available (i.e. at least one of the
// abovementioned checks fails). Dispatch stall events are counted during the
// entire execution of the code, and displayed by the performance report when
// flag '-verbose' is specified.
//
// If the number of micro opcodes of an instruction is bigger than
// DispatchWidth, then it can only be dispatched at the beginning of one cycle.
// The DispatchUnit will still have to wait for a number of cycles (depending on
// the DispatchWidth and the number of micro opcodes) before it can serve other
// instructions.
class DispatchUnit {
  unsigned DispatchWidth;
  unsigned AvailableEntries;
  unsigned CarryOver;
  Scheduler *SC;

  std::unique_ptr<RegisterFile> RAT;
  std::unique_ptr<RetireControlUnit> RCU;
  Backend *Owner;

  bool checkRAT(const InstRef &IR);
  bool checkRCU(const InstRef &IR);
  bool checkScheduler(const InstRef &IR);

  void updateRAWDependencies(ReadState &RS, const llvm::MCSubtargetInfo &STI);
  void notifyInstructionDispatched(const InstRef &IR,
                                   llvm::ArrayRef<unsigned> UsedPhysRegs);

public:
  DispatchUnit(Backend *B, const llvm::MCSchedModel &SM,
               const llvm::MCRegisterInfo &MRI, unsigned RegisterFileSize,
               unsigned MaxDispatchWidth, Scheduler *Sched)
      : DispatchWidth(MaxDispatchWidth), AvailableEntries(MaxDispatchWidth),
        CarryOver(0U), SC(Sched),
        RAT(llvm::make_unique<RegisterFile>(SM, MRI, RegisterFileSize)),
        RCU(llvm::make_unique<RetireControlUnit>(SM, this)), Owner(B) {}

  unsigned getDispatchWidth() const { return DispatchWidth; }

  bool isAvailable(unsigned NumEntries) const {
    return NumEntries <= AvailableEntries || AvailableEntries == DispatchWidth;
  }

  bool isRCUEmpty() const { return RCU->isEmpty(); }

  bool canDispatch(const InstRef &IR) {
    assert(isAvailable(IR.getInstruction()->getDesc().NumMicroOps));
    return checkRCU(IR) && checkRAT(IR) && checkScheduler(IR);
  }

  void dispatch(InstRef IR, const llvm::MCSubtargetInfo &STI);

  void collectWrites(llvm::SmallVectorImpl<WriteState *> &Vec,
                     unsigned RegID) const {
    return RAT->collectWrites(Vec, RegID);
  }

  void cycleEvent() {
    RCU->cycleEvent();
    AvailableEntries =
        CarryOver >= DispatchWidth ? 0 : DispatchWidth - CarryOver;
    CarryOver = CarryOver >= DispatchWidth ? CarryOver - DispatchWidth : 0U;
  }

  void notifyInstructionRetired(const InstRef &IR);

  void notifyDispatchStall(const InstRef &IR, unsigned EventType);

  void onInstructionExecuted(unsigned TokenID) {
    RCU->onInstructionExecuted(TokenID);
  }

#ifndef NDEBUG
  void dump() const;
#endif
};
} // namespace mca

#endif
