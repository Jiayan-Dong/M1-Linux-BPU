
	.arch armv8-a
	.file	"mispred_test.c"
	.text
	.global	a
	.bss
	.align	3
	.type	a, %object
	.size	a, 8000
a:
	.zero	8000
	.text
	.align	2
	.global	genRand
	.type	genRand, %function
genRand:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	mov	x0, 0
	bl	time
	bl	srand
	str	wzr, [sp, 28]
	b	.L2
.L3:
	bl	rand
	cmp	w0, 0
	and	w0, w0, 1
	csneg	w2, w0, w0, ge
	adrp	x0, a
	add	x0, x0, :lo12:a
	ldrsw	x1, [sp, 28]
	str	w2, [x0, x1, lsl 2]
	ldr	w0, [sp, 28]
	add	w0, w0, 1
	str	w0, [sp, 28]
.L2:
	ldr	w0, [sp, 28]
	cmp	w0, 1999
	ble	.L3
	nop
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	genRand, .-genRand
	.section	.rodata
	.align	3
.LC0:
	.string	"sched_setaffinity([0])"
	.align	3
.LC1:
	.string	"python3 -c 'import math'"
	.align	3
.LC2:
	.string	"%5.3f\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB7:
	.cfi_startproc
	mov	x12, 32192
	sub	sp, sp, x12
	.cfi_def_cfa_offset 32192
	stp	x29, x30, [sp]
	.cfi_offset 29, -32192
	.cfi_offset 30, -32184
	mov	x29, sp
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, :got_lo12:__stack_chk_guard]
	ldr	x1, [x0]
	str	x1, [sp, 32184]
	mov	x1, 0
	
	// CPU NUMBER
	mov	w0, 0 
	
	str	w0, [sp, 20]
	add	x0, sp, 184
	movi	v0.4s, 0
	stp	q0, q0, [x0]
	stp	q0, q0, [x0, 32]
	stp	q0, q0, [x0, 64]
	stp	q0, q0, [x0, 96]
	ldrsw	x0, [sp, 20]
	str	x0, [sp, 64]
	ldr	x0, [sp, 64]
	cmp	x0, 1023
	bhi	.L6
	ldr	x0, [sp, 64]
	lsr	x0, x0, 6
	lsl	x1, x0, 3
	add	x2, sp, 184
	add	x1, x2, x1
	ldr	x2, [x1]
	ldr	x1, [sp, 64]
	and	w1, w1, 63
	mov	x3, 1
	lsl	x1, x3, x1
	lsl	x0, x0, 3
	add	x3, sp, 184
	add	x0, x3, x0
	orr	x1, x2, x1
	str	x1, [x0]
.L6:
	add	x0, sp, 184
	mov	x2, x0
	mov	x1, 128
	mov	w0, 0
	bl	sched_setaffinity
	str	w0, [sp, 24]
	ldr	w0, [sp, 24]
	cmn	w0, #1
	bne	.L7
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	perror
	mov	w0, -1
	bl	exit
.L7:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	system
	str	w0, [sp, 28]
	add	x0, sp, 88
	mov	x2, 96
	mov	w1, 0
	bl	memset
	add	x0, sp, 88
	bl	perf_open
	str	xzr, [sp, 32]
	str	xzr, [sp, 40]
	str	xzr, [sp, 72]
	str	xzr, [sp, 48]
	str	xzr, [sp, 48]
	b	.L8
.L15:
	add	x0, sp, 184
	mov	x1, 32000
	mov	x2, x1
	mov	w1, 0
	bl	memset
	str	wzr, [sp, 16]
	b	.L9
.L12:
	str	xzr, [sp, 72]
	bl	genRand
	str	xzr, [sp, 32]
	add	x0, sp, 88
	bl	perf_start
	adrp	x0, a
	add	x0, x0, :lo12:a
	ldrsw	x1, [sp, 16]
	ldr	w0, [x0, x1, lsl 2]
	cmp	w0, 0
	beq	.L10
	ldr	x0, [sp, 32]
	add	x0, x0, 1
	str	x0, [sp, 32]
.L10:
.p2align 20
b LBB3_0
.p2align 20
LBB3_0:
b LBB3_1
.p2align 20
LBB3_1:

	

	ldr	x0, [sp, 32]
	cmp	x0, 0
	beq	.L11
	ldr	x0, [sp, 40]
	add	x0, x0, 1
	str	x0, [sp, 40]
.L11:
	add	x1, sp, 184
	ldrsw	x0, [sp, 16]
	lsl	x0, x0, 5
	add	x1, x1, x0
	add	x0, sp, 88
	bl	perf_stop
	ldr	w0, [sp, 16]
	add	w0, w0, 1
	str	w0, [sp, 16]
.L9:
	ldr	w0, [sp, 16]
	cmp	w0, 999
	ble	.L12
	str	xzr, [sp, 56]
	str	wzr, [sp, 16]
	b	.L13
.L14:
	ldrsw	x0, [sp, 16]
	lsl	x0, x0, 5
	add	x1, sp, 200
	ldr	d0, [x1, x0]
	ucvtf	d0, d0
	str	d0, [sp, 80]
	ldr	d1, [sp, 56]
	ldr	d0, [sp, 80]
	fadd	d0, d1, d0
	str	d0, [sp, 56]
	ldr	w0, [sp, 16]
	add	w0, w0, 1
	str	w0, [sp, 16]
.L13:
	ldr	w0, [sp, 16]
	cmp	w0, 999
	ble	.L14
	mov	x0, 70368744177664
	movk	x0, 0x408f, lsl 48
	fmov	d1, x0
	ldr	d0, [sp, 56]
	fdiv	d0, d0, d1
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	ldr	x0, [sp, 48]
	add	x0, x0, 1
	str	x0, [sp, 48]
.L8:
	ldr	x0, [sp, 48]
	cmp	x0, 19
	bls	.L15
	mov	w0, 0
	mov	w1, w0
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, :got_lo12:__stack_chk_guard]
	ldr	x3, [sp, 32184]
	ldr	x2, [x0]
	subs	x3, x3, x2
	mov	x2, 0
	beq	.L17
	bl	__stack_chk_fail
.L17:
	mov	w0, w1
	ldp	x29, x30, [sp]
	mov	x12, 32192
	add	sp, sp, x12
	.cfi_restore 29
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (GNU) 12.1.0"
	.section	.note.GNU-stack,"",@progbits

