# swap.asm
# ENCM 369 Winter 2026 Lab 3 Exercise F

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

# int foo[] =  0x600, 0x500, 0x400, 0x300, 0x200, 0x100}
	.data
        .globl	foo
foo:	.word	0x600, 0x500, 0x400, 0x300, 0x200, 0x100

# int main(void)
#
        .text
        .globl  main
main:
	addi	sp, sp, -32      # allocate stack space
	sw	ra, 0(sp)          # save return address

	la	t0, foo            # t0 = &foo[0]
	mv      a0, t0          # a0 = &foo[0]
	addi	a1, t0, 20       # a1 = &foo[5]
	jal	swap               # call swap(foo[0], foo[5])

	la	t0, foo            # reload base address of foo
	addi    a0, t0, 4       # a0 = &foo[1]
	addi	a1, t0, 16       # a1 = &foo[4]
	jal	swap               # call swap(foo[1], foo[4])

	la	t0, foo            # reload base address of foo
	addi    a0, t0, 8       # a0 = &foo[2]
	addi	a1, t0, 12       # a1 = &foo[3]
	jal	swap               # call swap(foo[2], foo[3])

	add	a0, zero, zero     # set return value = 0
	lw	ra, 0(sp)           # restore return address
	addi	sp, sp, 32        # deallocate stack space
	jr	ra                   # return from main

# void swap(int *p, int *q)
.text
.globl  swap
swap:
	lw	t0, 0(a0)           # load *p into t0
	lw	t1, 0(a1)           # load *q into t1
	sw	t0, 0(a1)           # store t0 into *q
	sw	t1, 0(a0)           # store t1 into *p
	jr	ra                   # return from swap
