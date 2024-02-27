# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	newline: .asciiz "\n"

.text
printA:
	li $t1, 1
	li $t2, 4
	sub $a1, $a1, $t1			#decrement to last index of array
	sll $t0, $a1, 2				#byte offset to last element
	add $t0, $a0, $t0			#address of last element

printLoop:
	li $t3, -1
	ble $a1, $t3, exitLoop		#if index is less than 0, exit

	lw $a0, 0($t0)				#load word at $t0 into $a0

	li $v0, 1					#print element at that index
	syscall
    
	la $a0, newline
	li $v0, 4
	syscall

	sub $t0, $t0, $t2			#decrement to next index
	sub $a1, $a1, $t1			#decrement index

	j printLoop

exitLoop:
	jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	li $v0, 10
	syscall

