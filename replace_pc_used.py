import subprocess
import shlex
import sys
import os
import random

up = """
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
	.string	"%5.3f\\n"
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
"""

down = """
	

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

"""

def unc_branch(n, align=2):
    bs = ""
    bs += ".p2align "+ str(align) + "\n"
    for i in range(n):
        if i < 100:
            bs += "b LBB3_" + str(i) + "\n"
            bs += ".p2align "+ str(align) + "\n"
            bs += "LBB3_" + str(i) + ":\n"
        elif i < 200:
            bs += "b LBB4_" + str(i-100) + "\n"
            bs += ".p2align "+ str(align) + "\n"
            bs += "LBB4_" + str(i-100) + ":\n"
        elif i < 300:
            bs += "b LBB5_" + str(i-200) + "\n"
            bs += ".p2align "+ str(align) + "\n"
            bs += "LBB5_" + str(i-200) + ":\n"
        elif i < 400:
            bs += "b LBB6_" + str(i-300) + "\n"
            bs += ".p2align "+ str(align) + "\n"
            bs += "LBB6_" + str(i-300) + ":\n"
        else:
            bs += "b LBB7_" + str(i-400) + "\n"
            bs += ".p2align "+ str(align) + "\n"
            bs += "LBB7_" + str(i-400) + ":\n"
    return bs

def always_taken_branch(n):
    bs = "mov w8, #0\n"
    for i in range(n):
        if i < 100:
            bs += "cbz w8, LBB3_" + str(i) + "\n"
            bs += "LBB3_" + str(i) + ":\n"
        elif i < 200:
            bs += "cbz w8, LBB4_" + str(i-100) + "\n"
            bs += "LBB4_" + str(i-100) + ":\n"
        elif i < 300:
            bs += "cbz w8, LBB5_" + str(i-200) + "\n"
            bs += "LBB5_" + str(i-200) + ":\n"
        elif i < 400:
            bs += "cbz w8, LBB6_" + str(i-300) + "\n"
            bs += "LBB6_" + str(i-300) + ":\n"
        else:
            bs += "cbz w8, LBB7_" + str(i-400) + "\n"
            bs += "LBB7_" + str(i-400) + ":\n"
    return bs

def always_not_taken_branch(n):
    bs = "mov w8, #1\n"
    for i in range(n):
        if i < 100:
            bs += "cbz w8, LBB3_" + str(i) + "\n"
            bs += "LBB3_" + str(i) + ":\n"
        elif i < 200:
            bs += "cbz w8, LBB4_" + str(i-100) + "\n"
            bs += "LBB4_" + str(i-100) + ":\n"
        elif i < 300:
            bs += "cbz w8, LBB5_" + str(i-200) + "\n"
            bs += "LBB5_" + str(i-200) + ":\n"
        elif i < 400:
            bs += "cbz w8, LBB6_" + str(i-300) + "\n"
            bs += "LBB6_" + str(i-300) + ":\n"
        else:
            bs += "cbz w8, LBB7_" + str(i-400) + "\n"
            bs += "LBB7_" + str(i-400) + ":\n"
    return bs

def mixed_branch(n):
	bs = ""
	bs = "mov w8, #1\n"
	bs += "mov w7, #0\n"
	for i in range(n):
		r = random.randint(0,2)
		if i < 100:
			if r == 0:
				bs += "cbz w8, LBB3_" + str(i) + "\n"
				bs += "LBB3_" + str(i) + ":\n"
			elif r == 1:
				bs += "b LBB3_" + str(i) + "\n"
				bs += "LBB3_" + str(i) + ":\n"
			else:
				bs += "cbz w7, LBB3_" + str(i) + "\n"
				bs += "LBB3_" + str(i) + ":\n"

		elif i < 200:
			if r == 0:
				bs += "cbz w8, LBB4_" + str(i) + "\n"
				bs += "LBB4_" + str(i) + ":\n"
			elif r == 1:
				bs += "b LBB4_" + str(i) + "\n"
				bs += "LBB4_" + str(i) + ":\n"
			else:
				bs += "cbz w7, LBB4_" + str(i) + "\n"
				bs += "LBB4_" + str(i) + ":\n"
	return bs


bb = []
for i in range(10):
	with open("mispred_test.s", "w") as file:
		file.write(up + unc_branch(i, 20) + down)
	os.system("gcc -no-pie -g -flto -O3 perf.c mispred_test.s -o mispred_test -pthread")
	p = subprocess.run(shlex.split("./mispred_test"),stdout=subprocess.PIPE)
	x_min1 = float("inf")
	for l in p.stdout.split(b'\n'):
		if not l:continue
		x = float(l.decode())
		x_min1 = min(x_min1, x)

	bb.append([i, x_min1])

	if i % 20 == 0: print(i, bb[-1])

import csv

with open("phr_Firestrom_used.csv", "w") as csvfile:
	writer = csv.writer(csvfile)
	writer.writerow(["", ""])
	writer.writerows(bb)

