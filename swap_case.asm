# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

# DO NOT MODIFY THE MAIN PROGRAM
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    li $t5, 0                           # index for iterating through the string

loop:
    lb $t0, buffer($t5)                 # load byte from string
    beq $t0, $zero, end                 # if null terminator, end loop

    # Print original character followed by newline
    move $a0, $t0                       # move character to $a0 for printing
    li $v0, 11                          # syscall for printing character
    syscall
    la $a0, newline                     # load address of newline character
    li $v0, 4                           # syscall for printing string
    syscall

    
    li $t6, 0                           # flag for swapping

    # Check if char is uppercase or lowercase and convert
    li $t1, 'A'
    li $t2, 'Z'
    li $t3, 'a'
    li $t4, 'z'
    blt $t0, $t1, checkLower            # skip to lowercase check if less than 'A'
    ble $t0, $t2, convertToLower        # convert to lowercase if between 'A' and 'Z'
    j checkLower                        # jump to lowercase check

convertToLower:
    addi $t0, $t0, 32                   # convert uppercase to lowercase
    li $t6, 1                           # set swap flag
    j storeChar                         # jump to storeChar

checkLower:
    blt $t0, $t3, printConventionCheck  # if not a letter, jump to print convention check directly
    ble $t0, $t4, convertToUpper        # convert to uppercase if between 'a' and 'z'
    j printConventionCheck              # jump to printConventionCheck if it's not a letter

convertToUpper:
    addi $t0, $t0, -32                  # convert lowercase to uppercase
    li $t6, 1                           # set swap flag

storeChar:
    sb $t0, buffer($t5)                 # store the converted character back in buffer

    # Print converted character followed by newline
    move $a0, $t0                       # move converted character to $a0 for printing
    li $v0, 11                          # syscall for printing character
    syscall
    la $a0, newline                     # load address of newline character
    li $v0, 4                           # syscall for printing string
    syscall

printConventionCheck:
    beq $t6, $0, notLetter              # if no swap occurred, jump to notLetter
    # Print "Convention Check" message
    la $a0, convention
    li $v0, 4
    syscall

notLetter:
    addi $t5, $t5, 1                    # increment index to next character
    j loop                              # jump back to start of loop

end:
    jr $ra                              # return from SwapCase

