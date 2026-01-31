# add-ints2C.asm
# ENCM 369 Winter 2026 Lab 2 Exercise C Part 2

# Start-up and clean-up code copied from stub1.asm

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
	addi s0,t2,-72
	sub s7, s6, t6
	lw t2, 24(t1)
	sw t3,(s2)
# END of start-up & clean-up code.

# Global variables.
.data
.globl alpha
alpha: .word 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1
.globl beta
beta: .word 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70


# Instructions for main	
	.text
	.globl	main
main:
#for loop Setup
	addi 	s3,zero,1	#i = 1
	addi	s4,zero,8	#i limit = 8
	bge	s3,s4,L3		#if limit = 0 Skip For loop
	la	s5, alpha	#Storage of Alpha Address
	lw	s6,(s5)		#load alpha[0]
#For Loop Begins
L2:
	mv	s7,s6		#move value of alpha current into max
				#**This Reg Will Be Where The Max Value of Alpha Survies Past L1 Into The While Loop Do Not OverWrite!!!**
L2.1:
	lw	s6,(s5)		#load value at Alpha pointer
	addi	s3,s3,1		#increment loop counter
	addi	s5,s5,4		#increment alpha pointer
	ble	s7,s6,L2		#compare max and alpha current
	blt	s3,s4,L2.1	#compare if i<i limit
L3:
#For Loop Ends
#----------------------------------------------
#While loop Setup
	la	s4,alpha		#gaurd = &alpha
	addi	s4,s4,0x20	#gaurd = &alpha + 32 bytes
	la	s5,alpha		#p = alpha
	beq	s5,s4,L4		#Skip While loop if guard == p;
	la	s6,beta		#q = beta
	addi	s6,s6,28		#beta = beta + 28 bytes
#While Loop beings
L5:	
	lw	s3,(s5)		#alpha loads s3
	sw	s3,(s6)		#s3 loads beta
	addi	s5,s5,4		#increment alpha pointer by 4 vytes
	addi	s6,s6,-4		#increment beta pointer by 4 bytes
	bne	s4,s5,L5		#compare if P!=gaurd
L4:
#While Loop Ends
	jr	ra
