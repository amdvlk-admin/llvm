; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN %s

; GCN-LABEL: {{^}}sample_1d:
; GCN: image_sample v[0:3], v0, s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_tfe:
; GCN: image_sample v[0:7], v5, s[0:7], s[8:11] dmask:0xf tfe{{$}}
define amdgpu_ps <8 x float> @sample_1d_tfe(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  ret <8 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_1:
; GCN: image_sample v[0:1], v2, s[0:7], s[8:11] dmask:0x1 tfe{{$}}
define amdgpu_ps <2 x float> @sample_1d_tfe_adjust_writemask_1(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f = extractelement <8 x float> %v, i32 0
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp = insertelement <2 x float> undef, float %res.f, i32 0
  %res = insertelement <2 x float> %res.tmp, float %res.err, i32 1
  ret <2 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_2:
; GCN: image_sample v[0:1], v2, s[0:7], s[8:11] dmask:0x2 tfe{{$}}
define amdgpu_ps <2 x float> @sample_1d_tfe_adjust_writemask_2(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f = extractelement <8 x float> %v, i32 1
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp = insertelement <2 x float> undef, float %res.f, i32 0
  %res = insertelement <2 x float> %res.tmp, float %res.err, i32 1
  ret <2 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_3:
; GCN: image_sample v[0:1], v2, s[0:7], s[8:11] dmask:0x4 tfe{{$}}
define amdgpu_ps <2 x float> @sample_1d_tfe_adjust_writemask_3(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f = extractelement <8 x float> %v, i32 2
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp = insertelement <2 x float> undef, float %res.f, i32 0
  %res = insertelement <2 x float> %res.tmp, float %res.err, i32 1
  ret <2 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_4:
; GCN: image_sample v[0:1], v2, s[0:7], s[8:11] dmask:0x8 tfe{{$}}
define amdgpu_ps <2 x float> @sample_1d_tfe_adjust_writemask_4(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f = extractelement <8 x float> %v, i32 3
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp = insertelement <2 x float> undef, float %res.f, i32 0
  %res = insertelement <2 x float> %res.tmp, float %res.err, i32 1
  ret <2 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_12:
; GCN: image_sample v[0:2], v3, s[0:7], s[8:11] dmask:0x3 tfe{{$}}
define amdgpu_ps <4 x float> @sample_1d_tfe_adjust_writemask_12(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f1 = extractelement <8 x float> %v, i32 0
  %res.f2 = extractelement <8 x float> %v, i32 1
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp1 = insertelement <4 x float> undef, float %res.f1, i32 0
  %res.tmp2 = insertelement <4 x float> %res.tmp1, float %res.f2, i32 1
  %res = insertelement <4 x float> %res.tmp2, float %res.err, i32 2
  ret <4 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_24:
; GCN: image_sample v[0:2], v3, s[0:7], s[8:11] dmask:0xa tfe{{$}}
define amdgpu_ps <4 x float> @sample_1d_tfe_adjust_writemask_24(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f1 = extractelement <8 x float> %v, i32 1
  %res.f2 = extractelement <8 x float> %v, i32 3
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp1 = insertelement <4 x float> undef, float %res.f1, i32 0
  %res.tmp2 = insertelement <4 x float> %res.tmp1, float %res.f2, i32 1
  %res = insertelement <4 x float> %res.tmp2, float %res.err, i32 2
  ret <4 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_tfe_adjust_writemask_134:
; GCN: image_sample v[0:3], v4, s[0:7], s[8:11] dmask:0xd tfe{{$}}
define amdgpu_ps <4 x float> @sample_1d_tfe_adjust_writemask_134(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 1, i32 0)
  %res.f1 = extractelement <8 x float> %v, i32 0
  %res.f2 = extractelement <8 x float> %v, i32 2
  %res.f3 = extractelement <8 x float> %v, i32 3
  %res.err = extractelement <8 x float> %v, i32 4
  %res.tmp1 = insertelement <4 x float> undef, float %res.f1, i32 0
  %res.tmp2 = insertelement <4 x float> %res.tmp1, float %res.f2, i32 1
  %res.tmp3 = insertelement <4 x float> %res.tmp2, float %res.f3, i32 2
  %res = insertelement <4 x float> %res.tmp3, float %res.err, i32 3
  ret <4 x float> %res
}

; GCN-LABEL: {{^}}sample_1d_lwe:
; GCN: image_sample v[0:7], v5, s[0:7], s[8:11] dmask:0xf lwe{{$}}
define amdgpu_ps <8 x float> @sample_1d_lwe(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 2, i32 0)
  ret <8 x float> %v
}

; GCN-LABEL: {{^}}sample_2d:
; GCN: image_sample v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.2d.v4f32.f32(i32 15, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_3d:
; GCN: image_sample v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_3d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t, float %r) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.3d.v4f32.f32(i32 15, float %s, float %t, float %r, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cube:
; GCN: image_sample v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf da{{$}}
define amdgpu_ps <4 x float> @sample_cube(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t, float %face) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cube.v4f32.f32(i32 15, float %s, float %t, float %face, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_1darray:
; GCN: image_sample v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf da{{$}}
define amdgpu_ps <4 x float> @sample_1darray(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %slice) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1darray.v4f32.f32(i32 15, float %s, float %slice, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_2darray:
; GCN: image_sample v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf da{{$}}
define amdgpu_ps <4 x float> @sample_2darray(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t, float %slice) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.2darray.v4f32.f32(i32 15, float %s, float %t, float %slice, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_1d:
; GCN: image_sample_c v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.1d.v4f32.f32(i32 15, float %zcompare, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_2d:
; GCN: image_sample_c v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.2d.v4f32.f32(i32 15, float %zcompare, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cl_1d:
; GCN: image_sample_cl v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cl.1d.v4f32.f32(i32 15, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cl_2d:
; GCN: image_sample_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cl.2d.v4f32.f32(i32 15, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cl_1d:
; GCN: image_sample_c_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cl.1d.v4f32.f32(i32 15, float %zcompare, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cl_2d:
; GCN: image_sample_c_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cl.2d.v4f32.f32(i32 15, float %zcompare, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_b_1d:
; GCN: image_sample_b v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_b_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.b.1d.v4f32.f32.f32(i32 15, float %bias, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_b_2d:
; GCN: image_sample_b v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_b_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.b.2d.v4f32.f32.f32(i32 15, float %bias, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_b_1d:
; GCN: image_sample_c_b v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_b_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %zcompare, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.b.1d.v4f32.f32.f32(i32 15, float %bias, float %zcompare, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_b_2d:
; GCN: image_sample_c_b v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_b_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %zcompare, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.b.2d.v4f32.f32.f32(i32 15, float %bias, float %zcompare, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_b_cl_1d:
; GCN: image_sample_b_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_b_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.b.cl.1d.v4f32.f32.f32(i32 15, float %bias, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_b_cl_2d:
; GCN: image_sample_b_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_b_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.b.cl.2d.v4f32.f32.f32(i32 15, float %bias, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_b_cl_1d:
; GCN: image_sample_c_b_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_b_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %zcompare, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.b.cl.1d.v4f32.f32.f32(i32 15, float %bias, float %zcompare, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_b_cl_2d:
; GCN: image_sample_c_b_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_b_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %bias, float %zcompare, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.b.cl.2d.v4f32.f32.f32(i32 15, float %bias, float %zcompare, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_d_1d:
; GCN: image_sample_d v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_d_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dsdv, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.d.1d.v4f32.f32.f32(i32 15, float %dsdh, float %dsdv, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_d_2d:
; GCN: image_sample_d v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_d_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.d.2d.v4f32.f32.f32(i32 15, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_d_1d:
; GCN: image_sample_c_d v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_d_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dsdv, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.1d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dsdv, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_d_2d:
; GCN: image_sample_c_d v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_d_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.2d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_d_cl_1d:
; GCN: image_sample_d_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_d_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dsdv, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.d.cl.1d.v4f32.f32.f32(i32 15, float %dsdh, float %dsdv, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_d_cl_2d:
; GCN: image_sample_d_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_d_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.d.cl.2d.v4f32.f32.f32(i32 15, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_d_cl_1d:
; GCN: image_sample_c_d_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_d_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dsdv, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.cl.1d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dsdv, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_d_cl_2d:
; GCN: image_sample_c_d_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_d_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.d.cl.2d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cd_1d:
; GCN: image_sample_cd v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cd_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dsdv, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cd.1d.v4f32.f32.f32(i32 15, float %dsdh, float %dsdv, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cd_2d:
; GCN: image_sample_cd v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cd_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cd.2d.v4f32.f32.f32(i32 15, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cd_1d:
; GCN: image_sample_c_cd v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cd_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dsdv, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cd.1d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dsdv, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cd_2d:
; GCN: image_sample_c_cd v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cd_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cd.2d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cd_cl_1d:
; GCN: image_sample_cd_cl v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cd_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dsdv, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cd.cl.1d.v4f32.f32.f32(i32 15, float %dsdh, float %dsdv, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_cd_cl_2d:
; GCN: image_sample_cd_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_cd_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.cd.cl.2d.v4f32.f32.f32(i32 15, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cd_cl_1d:
; GCN: image_sample_c_cd_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cd_cl_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dsdv, float %s, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cd.cl.1d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dsdv, float %s, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_cd_cl_2d:
; GCN: image_sample_c_cd_cl v[0:3], v[0:7], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_cd_cl_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.cd.cl.2d.v4f32.f32.f32(i32 15, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %clamp, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_l_1d:
; GCN: image_sample_l v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_l_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %lod) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.l.1d.v4f32.f32(i32 15, float %s, float %lod, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_l_2d:
; GCN: image_sample_l v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_l_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t, float %lod) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.l.2d.v4f32.f32(i32 15, float %s, float %t, float %lod, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_l_1d:
; GCN: image_sample_c_l v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_l_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %lod) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.l.1d.v4f32.f32(i32 15, float %zcompare, float %s, float %lod, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_l_2d:
; GCN: image_sample_c_l v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_l_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %t, float %lod) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.l.2d.v4f32.f32(i32 15, float %zcompare, float %s, float %t, float %lod, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_lz_1d:
; GCN: image_sample_lz v[0:3], v0, s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_lz_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.lz.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_lz_2d:
; GCN: image_sample_lz v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_lz_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.lz.2d.v4f32.f32(i32 15, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_lz_1d:
; GCN: image_sample_c_lz v[0:3], v[0:1], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_lz_1d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.lz.1d.v4f32.f32(i32 15, float %zcompare, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_lz_2d:
; GCN: image_sample_c_lz v[0:3], v[0:3], s[0:7], s[8:11] dmask:0xf{{$}}
define amdgpu_ps <4 x float> @sample_c_lz_2d(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %zcompare, float %s, float %t) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.c.lz.2d.v4f32.f32(i32 15, float %zcompare, float %s, float %t, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_c_d_o_2darray_V1:
; GCN: image_sample_c_d_o v0, v[0:15], s[0:7], s[8:11] dmask:0x4 da{{$}}
define amdgpu_ps float @sample_c_d_o_2darray_V1(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %slice) {
main_body:
  %v = call float @llvm.amdgcn.image.sample.c.d.o.2darray.f32.f32.f32(i32 4, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %slice, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret float %v
}

; GCN-LABEL: {{^}}sample_c_d_o_2darray_V2:
; GCN: image_sample_c_d_o v[0:1], v[0:15], s[0:7], s[8:11] dmask:0x6 da{{$}}
define amdgpu_ps <2 x float> @sample_c_d_o_2darray_V2(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %slice) {
main_body:
  %v = call <2 x float> @llvm.amdgcn.image.sample.c.d.o.2darray.v2f32.f32.f32(i32 6, i32 %offset, float %zcompare, float %dsdh, float %dtdh, float %dsdv, float %dtdv, float %s, float %t, float %slice, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 0)
  ret <2 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_unorm:
; GCN: image_sample v[0:3], v0, s[0:7], s[8:11] dmask:0xf unorm{{$}}
define amdgpu_ps <4 x float> @sample_1d_unorm(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 1, i32 0, i32 0)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_glc:
; GCN: image_sample v[0:3], v0, s[0:7], s[8:11] dmask:0xf glc{{$}}
define amdgpu_ps <4 x float> @sample_1d_glc(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 1)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_slc:
; GCN: image_sample v[0:3], v0, s[0:7], s[8:11] dmask:0xf slc{{$}}
define amdgpu_ps <4 x float> @sample_1d_slc(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 2)
  ret <4 x float> %v
}

; GCN-LABEL: {{^}}sample_1d_glc_slc:
; GCN: image_sample v[0:3], v0, s[0:7], s[8:11] dmask:0xf glc slc{{$}}
define amdgpu_ps <4 x float> @sample_1d_glc_slc(<8 x i32> inreg %rsrc, <4 x i32> inreg %samp, float %s) {
main_body:
  %v = call <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32 15, float %s, <8 x i32> %rsrc, <4 x i32> %samp, i1 0, i32 0, i32 3)
  ret <4 x float> %v
}

declare <4 x float> @llvm.amdgcn.image.sample.1d.v4f32.f32(i32, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <8 x float> @llvm.amdgcn.image.sample.1d.v8f32.f32(i32, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.2d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.3d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cube.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.1darray.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.2darray.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.c.1d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.2d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cl.1d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cl.2d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cl.1d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cl.2d.v4f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.b.1d.v4f32.f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.b.2d.v4f32.f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.b.1d.v4f32.f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.b.2d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.b.cl.1d.v4f32.f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.b.cl.2d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.b.cl.1d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.b.cl.2d.v4f32.f32.f32(i32, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.d.1d.v4f32.f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.d.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.d.1d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.d.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.d.cl.1d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.d.cl.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.d.cl.1d.v4f32.f32.f32(i32, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.d.cl.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.cd.1d.v4f32.f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cd.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cd.1d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cd.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cd.cl.1d.v4f32.f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.cd.cl.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cd.cl.1d.v4f32.f32.f32(i32, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.cd.cl.2d.v4f32.f32.f32(i32, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.l.1d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.l.2d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.l.1d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.l.2d.v4f32.f32(i32, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare <4 x float> @llvm.amdgcn.image.sample.lz.1d.v4f32.f32(i32, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.lz.2d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.lz.1d.v4f32.f32(i32, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <4 x float> @llvm.amdgcn.image.sample.c.lz.2d.v4f32.f32(i32, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

declare float @llvm.amdgcn.image.sample.c.d.o.2darray.f32.f32.f32(i32, i32, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1
declare <2 x float> @llvm.amdgcn.image.sample.c.d.o.2darray.v2f32.f32.f32(i32, i32, float, float, float, float, float, float, float, float, <8 x i32>, <4 x i32>, i1, i32, i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
