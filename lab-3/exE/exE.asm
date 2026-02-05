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
aaa:
    .word 11, 11, 3, -11, 11, 11
bbb:
    .word 200, -300, 400, 500
ccc:
    .word -3, -4, 3, 2, 3, -4
    .text
    .globl main

#THIS IS THE SAT FN
 sat:
    add t1,a0,a1        # t1 = x + b
    bltz t1,returnNegB  # if x + b < 0, goto returnNegB
    bgt a0,a1,returnB   # if x > b, goto returnB
    j    returnSat      # else goto returnSat

returnNegB:
    sub a0,zero,a1      # a0 = -b
    j   returnSat       # jump to returnSat

returnB:
    mv a0,a1            # a0 = b

returnSat:
    jr ra               # return to caller

#THIS IS THE SUM_SAT FN
sum_of_sats:
    addi sp,sp,-32      # allocate stack
    sw   ra,0(sp)       # save return address
    sw   s0,28(sp)      # save s0
    sw   s1,24(sp)      # save s1
    sw   s2,20(sp)      # save s2
    sw   s3,16(sp)      # save s3
    sw   s4,12(sp)      # save s4
    add  s0,zero,a0     # s0 = array pointer
    add  s1,zero,a1     # s1 = n
    add  s2,zero,a2     # s2 = max_mag
    add  s3,zero,zero   # s3 = result = 0
    add  s4,zero,zero   # s4 = loop index i = 0
    mv   t0,s0          # t0 = current pointer
    blez s1,returnSumSat # if n <= 0, skip loop

TopLoop:
    lw   a0,0(t0)       # load a[i] into a0
    mv   a1,s2          # a1 = max_mag
    jal  sat            # call sat(a[i], max_mag)
    add  s3,s3,a0       # result += sat(a[i], max_mag)
    addi t0,t0,4        # move pointer to next element
    addi s4,s4,1        # i++
    blt  s4,s1,TopLoop  # if i < n, repeat loop

returnSumSat:
    mv   a0,s3          # move result into a0 for return
    lw   ra,0(sp)       # restore return address
    lw   s0,28(sp)      # restore s0
    lw   s1,24(sp)      # restore s1
    lw   s2,20(sp)      # restore s2
    lw   s3,16(sp)      # restore s3
    lw   s4,12(sp)      # restore s4
    addi sp,sp,32       # deallocate stack
    jr   ra             # return
    
#THIS IS THE MAIN FN
main:
    addi sp, sp, -32    # allocate stack space
    sw   ra, 0(sp)      # save return address
    sw   s0, 28(sp)     # save s0
    sw   s1, 24(sp)     # save s1
    sw   s2, 20(sp)     # save s2
    li   s0,3000        # s0 = initial value 3000
    li   a1,6           # a1 = size of aaa
    li   a2,9           # a2 = max_mag for aaa
    la   a0,aaa         # a0 = address of aaa
    jal  sum_of_sats    # call sum_of_sats(aaa,6,9)
    mv   s1,a0          # s1 = sum_of_sats result for aaa
    li   a1,4           # a1 = size of bbb
    li   a2,250         # a2 = max_mag for bbb
    la   a0,bbb         # a0 = address of bbb
    jal  sum_of_sats    # call sum_of_sats(bbb,4,250)
    mv   s2,a0          # s2 = sum_of_sats result for bbb
    li   a1,6           # a1 = size of ccc
    li   a2,3           # a2 = max_mag for ccc
    la   a0,ccc         # a0 = address of ccc
    jal  sum_of_sats    # call sum_of_sats(ccc,6,3)
    add  t0,s1,s2       # t0 = sum_aaa + sum_bbb
    add  t0,t0,a0       # t0 = sum_aaa + sum_bbb + sum_ccc
    add  s0,s0,t0       # s0 = initial + total sum
    li   a0,0           # a0 = 0 (return value for main)
    lw   ra, 0(sp)      # restore return address
    lw   s0, 28(sp)     # restore s0
    lw   s1, 24(sp)     # restore s1
    lw   s2, 20(sp)     # restore s2
    addi sp, sp, 32     # deallocate stack
    jr   ra             # return from main  