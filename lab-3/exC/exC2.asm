# stub1.asm
# ENCM 369 Winter 2026
# This program has complete start-up and clean-up code, and a "stub"
# main function.

# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciz	"***About to exit. main returned "
exit_msg_2:
	.asciz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust sp, then call main
	andi	sp, sp, -32		# round sp down to multiple of 32
	jal	main
	
	# when main is done, print its return value, then halt the program
	sw	a0, main_rv, t0	
	la	a0, exit_msg_1
	li      a7, 4
	ecall
	lw	a0, main_rv
	li	a7, 1
	ecall
	la	a0, exit_msg_2
	li	a7, 4
	ecall
        lw      a0, main_rv
	addi	a7, zero, 93	# call for program exit with exit status that is in a0
	ecall
# END of start-up & clean-up code.

# Below is the stub for main. Edit it to give main the desired behaviour.
	.data
	.globl orange
	orange: .word 0x30000
	
	.text
	.globl main
funcB:				#FuncB Call
	slli	a1,a1,6		#a1 = a1 * 64
	add	a0,a0,a1
	jr	ra
funcA:				#FuncA Call
	addi	sp,sp,-32
	sw	ra,0(sp)
	sw	a0,28(sp)	#First
	sw	a1,24(sp)	#Second
	sw	a2,20(sp)	#Third
	sw	a3,16(sp)	#Fourth
	mv	a0,a2
	mv	a1,a3		#
	jal	funcB
	sw	a0,12(sp)	#Store Return Value Car
	lw	a0,24(sp)
	lw	a1,28(sp)
	jal	funcB	
	sw	a0,8(sp)		#Store Return Value Bus
	lw	a0,16(sp)
	lw	a1,20(sp)
	jal	funcB
	lw	t1,8(sp)
	add	t0,t1,a0
	lw	t1,12(sp)
	add	a0,t0,t1
	lw	ra,0(sp)
	addi	sp,sp,32
	jr	ra
main:
	addi 	sp,sp,-32
	sw	ra,0(sp)
	li	a0,2
	li	a1,4
	li	a2,3
	li	a3,5
	jal	funcA
	addi	t1,a0,0x700	#Apple = Apple + FuncA(2,4,3,5)
	la	t0,orange	#t0 Load Address Of OrangeAddress
	lw	t2,0(t0)		#t2 = Load Value Of OrangeAddress (0x30000)
	li	t3,0x500		#t3 = 0x500
	sub	t1,t3,t1		#t1 = 0x500 - Apple
	add	t2,t2,t1		#OrangeValue = OrangeValue + (0x500 - Apple)
	sw	t2,0(t0)		#Store OrangeValue At OrangeAddress
	lw	ra,0(sp)
	li      	a0, 0   # return value from main = 0
	addi	sp,sp,32
	jr	ra
