# conversion.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    li $s0, 0               #z
    li $s1, 0               #loop counter

loop:
    li $t0, 8
    bge $s1, $t0, endLoop 
    sll $t1, $a0, 3         #8*x
    sub $s0, $s0, $t1       #z = z-8*x 
    add $s0, $s0, $a1       #z = z+y 

    slti $t2, $a0, 2   
    beq $t2, $zero, update_y
    
    j continueLoop

update_y:
    sub $a1, $a1, 1

continueLoop:
    add $a0, $a0, 1
    addi $s1, $s1, 1
    j loop

endLoop:
    move $v0, $s0

    jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:

    li $v0, 10
    syscall
	# TODO: Write code to properly exit a SPIM simulation


