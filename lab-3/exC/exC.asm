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
main:
	addi 	sp,sp,-32       # Allocate stack space
	sw	ra,0(sp)         # Save return address
	sw	s0,28(sp)        # Store S0 (Apple)
	sw	s1,24(sp)        # Store S1 (Banana)
	addi	s0,zero,0x700   # S0 = 0x700 (Apple)
	addi	s1,zero,0x500   # S1 = 0x500 (Banana)
	li	a0,2             # a0 = 2 (FuncA first arg)
	li	a1,4             # a1 = 4 (FuncA second arg)
	li	a2,3             # a2 = 3 (FuncA third arg)
	li	a3,5             # a3 = 5 (FuncA fourth arg)
	jal	funcA           # Call FuncA(2,4,3,5)
	add	s0,a0,s0         # Apple = Apple + FuncA return
	la	t0,orange        # t0 = &orange
	lw	t2,0(t0)         # t2 = orange
	sub	t1,s1,s0         # t1 = Banana - Apple
	add	t2,t2,t1         # t2 = orange + (Banana - Apple)
	sw	t2,0(t0)         # orange = t2
	lw	ra,0(sp)          # Restore return address
	lw	s0,28(sp)         # Restore S0 (Apple)
	lw	s1,24(sp)         # Restore S1 (Banana)
	li      	a0, 0        # return value from main = 0
	addi	sp,sp,32        # Deallocate stack space
	jr	ra                # Return from main

funcB:				# FuncB Call
	slli	a1,a1,6          # a1 = a1 * 64
	add	a0,a0,a1         # a0 = a0 + (a1*64)
	jr	ra                # Return from FuncB

funcA:				# FuncA Call
	addi	sp,sp,-32       # Allocate stack space
	sw	ra,0(sp)         # Save return address
	sw	s0,28(sp)        # Save old S0 (First)
	sw	s1,24(sp)        # Save old S1 (Second)
	sw	s2,20(sp)        # Save old S2 (Third)
	sw	s3,16(sp)        # Save old S3 (Fourth)
	sw	s4,12(sp)        # Save S4 (Bus)
	sw	s5,8(sp)         # Save S5 (Car)
	sw	s6,4(sp)         # Save S6 (Truck)
	mv	s0,a0             # S0 = First argument
	mv	s1,a1             # S1 = Second argument
	mv	s2,a2             # S2 = Third argument
	mv	s3,a3             # S3 = Fourth argument
	mv	a0,a2             # a0 = Third argument
	mv	a1,a3             # a1 = Fourth argument
	jal	funcB           # Call FuncB(Third, Fourth)
	mv	s4,a0             # Store return in S4 (Bus)
	mv	a0,s1             # a0 = Second argument
	mv	a1,s0             # a1 = First argument
	jal	funcB           # Call FuncB(Second, First)
	mv	s5,a0             # Store return in S5 (Car)
	mv	a0,s3             # a0 = Fourth argument
	mv	a1,s2             # a1 = Third argument
	jal	funcB           # Call FuncB(Fourth, Third)
	add	s4,s4,a0         # S4 = Bus + FuncB return
	add	a0,s4,s5         # a0 = S4 + Car (FuncA return)
	lw	ra,0(sp)          # Restore return address
	lw	s0,28(sp)         # Restore S0 (First)
	lw	s1,24(sp)         # Restore S1 (Second)
	lw	s2,20(sp)         # Restore S2 (Third)
	lw	s3,16(sp)         # Restore S3 (Fourth)
	lw	s4,12(sp)         # Restore S4 (Bus)
	lw	s5,8(sp)          # Restore S5 (Car)
	lw	s6,4(sp)          # Restore S6 (Truck)
	addi	sp,sp,32        # Deallocate stack space
	jr	ra                # Return from FuncA
