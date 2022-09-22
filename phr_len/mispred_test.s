
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
	mov	w0, 4 
	
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
b LBB3_0
LBB3_0:
b LBB3_1
LBB3_1:
b LBB3_2
LBB3_2:
b LBB3_3
LBB3_3:
b LBB3_4
LBB3_4:
b LBB3_5
LBB3_5:
b LBB3_6
LBB3_6:
b LBB3_7
LBB3_7:
b LBB3_8
LBB3_8:
b LBB3_9
LBB3_9:
b LBB3_10
LBB3_10:
b LBB3_11
LBB3_11:
b LBB3_12
LBB3_12:
b LBB3_13
LBB3_13:
b LBB3_14
LBB3_14:
b LBB3_15
LBB3_15:
b LBB3_16
LBB3_16:
b LBB3_17
LBB3_17:
b LBB3_18
LBB3_18:
b LBB3_19
LBB3_19:
b LBB3_20
LBB3_20:
b LBB3_21
LBB3_21:
b LBB3_22
LBB3_22:
b LBB3_23
LBB3_23:
b LBB3_24
LBB3_24:
b LBB3_25
LBB3_25:
b LBB3_26
LBB3_26:
b LBB3_27
LBB3_27:
b LBB3_28
LBB3_28:
b LBB3_29
LBB3_29:
b LBB3_30
LBB3_30:
b LBB3_31
LBB3_31:
b LBB3_32
LBB3_32:
b LBB3_33
LBB3_33:
b LBB3_34
LBB3_34:
b LBB3_35
LBB3_35:
b LBB3_36
LBB3_36:
b LBB3_37
LBB3_37:
b LBB3_38
LBB3_38:
b LBB3_39
LBB3_39:
b LBB3_40
LBB3_40:
b LBB3_41
LBB3_41:
b LBB3_42
LBB3_42:
b LBB3_43
LBB3_43:
b LBB3_44
LBB3_44:
b LBB3_45
LBB3_45:
b LBB3_46
LBB3_46:
b LBB3_47
LBB3_47:
b LBB3_48
LBB3_48:
b LBB3_49
LBB3_49:
b LBB3_50
LBB3_50:
b LBB3_51
LBB3_51:
b LBB3_52
LBB3_52:
b LBB3_53
LBB3_53:
b LBB3_54
LBB3_54:
b LBB3_55
LBB3_55:
b LBB3_56
LBB3_56:
b LBB3_57
LBB3_57:
b LBB3_58
LBB3_58:
b LBB3_59
LBB3_59:
b LBB3_60
LBB3_60:
b LBB3_61
LBB3_61:
b LBB3_62
LBB3_62:
b LBB3_63
LBB3_63:
b LBB3_64
LBB3_64:
b LBB3_65
LBB3_65:
b LBB3_66
LBB3_66:
b LBB3_67
LBB3_67:
b LBB3_68
LBB3_68:
b LBB3_69
LBB3_69:
b LBB3_70
LBB3_70:
b LBB3_71
LBB3_71:
b LBB3_72
LBB3_72:
b LBB3_73
LBB3_73:
b LBB3_74
LBB3_74:
b LBB3_75
LBB3_75:
b LBB3_76
LBB3_76:
b LBB3_77
LBB3_77:
b LBB3_78
LBB3_78:
b LBB3_79
LBB3_79:
b LBB3_80
LBB3_80:
b LBB3_81
LBB3_81:
b LBB3_82
LBB3_82:
b LBB3_83
LBB3_83:
b LBB3_84
LBB3_84:
b LBB3_85
LBB3_85:
b LBB3_86
LBB3_86:
b LBB3_87
LBB3_87:
b LBB3_88
LBB3_88:
b LBB3_89
LBB3_89:
b LBB3_90
LBB3_90:
b LBB3_91
LBB3_91:
b LBB3_92
LBB3_92:
b LBB3_93
LBB3_93:
b LBB3_94
LBB3_94:
b LBB3_95
LBB3_95:
b LBB3_96
LBB3_96:
b LBB3_97
LBB3_97:
b LBB3_98
LBB3_98:

	

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

