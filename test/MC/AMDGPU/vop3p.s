// RUN: llvm-mc -arch=amdgcn -mcpu=gfx901 -show-encoding %s | FileCheck -check-prefix=GFX9 %s

//
// Test op_sel/op_sel_hi
//

v_pk_add_u16 v1, v2, v3
// GFX9: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0]
// GFX9: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,1]
// GFX9: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0] op_sel_hi:[1,1]
// GFX9: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0] ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x00]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0] op_sel_hi:[0,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0] ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x00]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] ; encoding: [0x01,0x08,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] ; encoding: [0x01,0x10,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[1,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[1,1] ; encoding: [0x01,0x18,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,1] ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,0] ; encoding: [0x01,0x00,0x8a,0xd3,0x02,0x07,0x02,0x08]

v_pk_add_u16 v1, v2, v3 op_sel:[1,1] op_sel_hi:[1,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[1,1] ; encoding: [0x01,0x18,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[1,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[1,0] ; encoding: [0x01,0x08,0x8a,0xd3,0x02,0x07,0x02,0x08]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[0,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[0,1] ; encoding: [0x01,0x10,0x8a,0xd3,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[0,1]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[0,1] ; encoding: [0x01,0x08,0x8a,0xd3,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[1,0]
// GFX9: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[1,0] ; encoding: [0x01,0x10,0x8a,0xd3,0x02,0x07,0x02,0x08]

//
// Test src2 op_sel/op_sel_hi
//

v_pk_fma_f16 v8, v0, s0, v1
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,0] neg_hi:[0,0,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[1,1,1] neg_lo:[0,0,0] neg_hi:[0,0,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[1,1,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[0,0,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 op_sel_hi:[0,0,0] ; encoding: [0x08,0x00,0x8e,0xd3,0x00,0x01,0x04,0x04]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,1] op_sel_hi:[0,0,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,1] op_sel_hi:[0,0,1] ; encoding: [0x08,0x60,0x8e,0xd3,0x00,0x01,0x04,0x04]

//
// Test neg_lo/neg_hi
//

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0xfc]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,1,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,1,1] ; encoding: [0x08,0x47,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] neg_hi:[1,1,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] neg_hi:[1,1,1] ; encoding: [0x08,0x47,0x8e,0xd3,0x00,0x01,0x04,0xfc]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,0,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,0,0] ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x3c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,1,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,1,0] ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x5c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,1] ; encoding: [0x08,0x40,0x8e,0xd3,0x00,0x01,0x04,0x9c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,0,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,0,0] ; encoding: [0x08,0x41,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,1,0]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,1,0] ; encoding: [0x08,0x42,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,0,1]
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,0,1] ; encoding: [0x08,0x44,0x8e,0xd3,0x00,0x01,0x04,0x1c]


// Test clamp
v_pk_fma_f16 v8, v0, s0, v1 clamp
// GFX9: v_pk_fma_f16 v8, v0, s0, v1 clamp ; encoding: [0x08,0xc0,0x8e,0xd3,0x00,0x01,0x04,0x1c]

v_pk_add_u16 v1, v2, v3 clamp
// GFX9: v_pk_add_u16 v1, v2, v3 clamp ; encoding: [0x01,0x80,0x8a,0xd3,0x02,0x07,0x02,0x18]

v_pk_min_i16 v0, v1, v2 clamp
// GFX9: v_pk_min_i16 v0, v1, v2 clamp ; encoding: [0x00,0x80,0x88,0xd3,0x01,0x05,0x02,0x18]

//
// Instruction tests:
//

v_pk_mul_lo_u16 v0, v1, v2
// GFX9: v_pk_mul_lo_u16 v0, v1, v2 ; encoding: [0x00,0x00,0x81,0xd3,0x01,0x05,0x02,0x18]

v_pk_add_i16 v0, v1, v2
// GFX9: v_pk_add_i16 v0, v1, v2 ; encoding: [0x00,0x00,0x82,0xd3,0x01,0x05,0x02,0x18]

v_pk_sub_i16 v0, v1, v2
// GFX9: v_pk_sub_i16 v0, v1, v2 ; encoding: [0x00,0x00,0x83,0xd3,0x01,0x05,0x02,0x18]

v_pk_lshlrev_b16 v0, v1, v2
// GFX9: v_pk_lshlrev_b16 v0, v1, v2 ; encoding: [0x00,0x00,0x84,0xd3,0x01,0x05,0x02,0x18]

v_pk_lshrrev_b16 v0, v1, v2
// GFX9: v_pk_lshrrev_b16 v0, v1, v2 ; encoding: [0x00,0x00,0x85,0xd3,0x01,0x05,0x02,0x18]

v_pk_ashrrev_i16 v0, v1, v2
// GFX9: v_pk_ashrrev_i16 v0, v1, v2 ; encoding: [0x00,0x00,0x86,0xd3,0x01,0x05,0x02,0x18]

v_pk_max_i16 v0, v1, v2
// GFX9: v_pk_max_i16 v0, v1, v2 ; encoding: [0x00,0x00,0x87,0xd3,0x01,0x05,0x02,0x18]

v_pk_min_i16 v0, v1, v2
// GFX9: v_pk_min_i16 v0, v1, v2 ; encoding: [0x00,0x00,0x88,0xd3,0x01,0x05,0x02,0x18]

v_pk_add_u16 v0, v1, v2
// GFX9: v_pk_add_u16 v0, v1, v2 ; encoding: [0x00,0x00,0x8a,0xd3,0x01,0x05,0x02,0x18]

v_pk_max_u16 v0, v1, v2
// GFX9: v_pk_max_u16 v0, v1, v2 ; encoding: [0x00,0x00,0x8c,0xd3,0x01,0x05,0x02,0x18]

v_pk_min_u16 v0, v1, v2
// GFX9: v_pk_min_u16 v0, v1, v2 ; encoding: [0x00,0x00,0x8d,0xd3,0x01,0x05,0x02,0x18]

v_pk_fma_f16 v0, v1, v2, v3
// GFX9: v_pk_fma_f16 v0, v1, v2, v3 ; encoding: [0x00,0x40,0x8e,0xd3,0x01,0x05,0x0e,0x1c]

v_pk_add_f16 v0, v1, v2
// GFX9: v_pk_add_f16 v0, v1, v2 ; encoding: [0x00,0x00,0x8f,0xd3,0x01,0x05,0x02,0x18]

v_pk_mul_f16 v0, v1, v2
// GFX9: v_pk_mul_f16 v0, v1, v2 ; encoding: [0x00,0x00,0x90,0xd3,0x01,0x05,0x02,0x18]

v_pk_min_f16 v0, v1, v2
// GFX9: v_pk_min_f16 v0, v1, v2 ; encoding: [0x00,0x00,0x91,0xd3,0x01,0x05,0x02,0x18]

v_pk_max_f16 v0, v1, v2
// GFX9: v_pk_max_f16 v0, v1, v2 ; encoding: [0x00,0x00,0x92,0xd3,0x01,0x05,0x02,0x18]

v_mad_mix_f32 v0, v1, v2, v3
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mixlo_f16 v0, v1, v2, v3
// GFX9: v_mad_mixlo_f16 v0, v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa1,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mixhi_f16 v0, v1, v2, v3
// GFX9: v_mad_mixhi_f16 v0, v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa2,0xd3,0x01,0x05,0x0e,0x04]

//
// Regular source modifiers on non-packed instructions
//

v_mad_mix_f32 v0, abs(v1), v2, v3
// GFX9: v_mad_mix_f32 v0, |v1|, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x01,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, abs(v2), v3
// GFX9: v_mad_mix_f32 v0, v1, |v2|, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x02,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, abs(v3)
// GFX9: v_mad_mix_f32 v0, v1, v2, |v3| op_sel_hi:[0,0,0] ; encoding: [0x00,0x04,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, -v1, v2, v3
// GFX9: v_mad_mix_f32 v0, -v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x24]

v_mad_mix_f32 v0, v1, -v2, v3
// GFX9: v_mad_mix_f32 v0, v1, -v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x44]

v_mad_mix_f32 v0, v1, v2, -v3
// GFX9: v_mad_mix_f32 v0, v1, v2, -v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x84]

v_mad_mix_f32 v0, -abs(v1), v2, v3
// GFX9: v_mad_mix_f32 v0, -|v1|, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x01,0xa0,0xd3,0x01,0x05,0x0e,0x24]

v_mad_mix_f32 v0, v1, -abs(v2), v3
// GFX9: v_mad_mix_f32 v0, v1, -|v2|, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x02,0xa0,0xd3,0x01,0x05,0x0e,0x44]

v_mad_mix_f32 v0, v1, v2, -abs(v3)
// GFX9: v_mad_mix_f32 v0, v1, v2, -|v3| op_sel_hi:[0,0,0] ; encoding: [0x00,0x04,0xa0,0xd3,0x01,0x05,0x0e,0x84]

v_mad_mixlo_f16 v0, abs(v1), -v2, abs(v3)
// GFX9: v_mad_mixlo_f16 v0, |v1|, -v2, |v3| op_sel_hi:[0,0,0] ; encoding: [0x00,0x05,0xa1,0xd3,0x01,0x05,0x0e,0x44]

v_mad_mixhi_f16 v0, -v1, abs(v2), -abs(v3)
// GFX9: v_mad_mixhi_f16 v0, -v1, |v2|, -|v3| op_sel_hi:[0,0,0] ; encoding: [0x00,0x06,0xa2,0xd3,0x01,0x05,0x0e,0xa4]

v_mad_mixlo_f16 v0, v1, v2, v3 clamp
// GFX9: v_mad_mixlo_f16 v0, v1, v2, v3 op_sel_hi:[0,0,0] clamp ; encoding: [0x00,0x80,0xa1,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mixhi_f16 v0, v1, v2, v3 clamp
// GFX9: v_mad_mixhi_f16 v0, v1, v2, v3 op_sel_hi:[0,0,0] clamp ; encoding: [0x00,0x80,0xa2,0xd3,0x01,0x05,0x0e,0x04]

//
// op_sel with non-packed instructions
//

v_mad_mix_f32 v0, v1, v2, v3 op_sel:[0,0,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel:[1,0,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel:[1,0,0] op_sel_hi:[0,0,0] ; encoding: [0x00,0x08,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel:[0,1,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel:[0,1,0] op_sel_hi:[0,0,0] ; encoding: [0x00,0x10,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel:[0,0,1]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel:[0,0,1] op_sel_hi:[0,0,0] ; encoding: [0x00,0x20,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel:[1,1,1]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel:[1,1,1] op_sel_hi:[0,0,0] ; encoding: [0x00,0x38,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[1,0,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[1,0,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x0c]

v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,1,0]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,1,0] ; encoding: [0x00,0x00,0xa0,0xd3,0x01,0x05,0x0e,0x14]

v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,1]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[0,0,1] ; encoding: [0x00,0x40,0xa0,0xd3,0x01,0x05,0x0e,0x04]

v_mad_mix_f32 v0, v1, v2, v3 op_sel_hi:[1,1,1]
// GFX9: v_mad_mix_f32 v0, v1, v2, v3    ; encoding: [0x00,0x40,0xa0,0xd3,0x01,0x05,0x0e,0x1c]

v_mad_mixlo_f16 v0, v1, v2, v3 op_sel_hi:[1,0,1] clamp
// GFX9: v_mad_mixlo_f16 v0, v1, v2, v3 op_sel_hi:[1,0,1] clamp ; encoding: [0x00,0xc0,0xa1,0xd3,0x01,0x05,0x0e,0x0c]

v_mad_mixhi_f16 v0, v1, v2, v3 op_sel_hi:[1,0,1] clamp
// GFX9: v_mad_mixhi_f16 v0, v1, v2, v3 op_sel_hi:[1,0,1] clamp ; encoding: [0x00,0xc0,0xa2,0xd3,0x01,0x05,0x0e,0x0c]
