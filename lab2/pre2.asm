
.data
control: .asciiz "Enter y to stop: "
start: .asciiz "Enter number: "
startN: .asciiz "Enter n number to take complement: "
endL: .asciiz "\n"
.text
startLoop:
    la $a0, control    # put string address into a0
    li $v0,4           # system call to print
    syscall            #   out a string

    li   $v0, 12
    syscall	    # Read Character
    move $t2, $v0
    beq $t2, 121, finishLoop

    la $a0, endL    # put string address into a0
    li $v0,4        # system call to print
    syscall         # out a string

    la $a0, start    # put string address into a0
    li $v0,4         # system call to print
    syscall          # out a string

    la $v0,5        #taking integers
    syscall
    move $t0, $v0

    la $a0, startN    # put string address into a0
    li $v0,4          # system call to print
    syscall           # out a string

    la $v0,5  
    syscall
    move $t1, $v0

    move $a0, $t0 	# store integers in array 
    li $v0, 34
    syscall

    la $a0, endL    # put string address into a0
    li $v0,4        # system call to print
    syscall         # out a string

    move $a0, $t0
    move $a1, $t1
    jal bitComplementer
    move $t4, $v0

    move $a0, $t4
    li $v0, 34
    syscall
    j startLoop
    
finishLoop: 	#finish the calculation and write them
    li $v0, 10
    syscall

bitComplementer:   #change the bits via complement rule
    move $s0, $a0
    move $s1, $a1
    move $s2, $s0
    li $s3, 1
    li $s4, 1
    li $s6, 0
for:    
    beq $s6, $s1, finLoop
    beq $s6, 31, diffAction
    sll $s3, $s3, 1
    srl $s5, $s3, 1
    div $s0, $s3
    mfhi $s7
    beq $s7, $0, go
    sub $s0, $s0, $s5
    sub $s2, $s2, $s5
    addi $s6, $s6, 1
    j for
go:
    add $s2, $s2, $s5
    addi $s6, $s6, 1
    j for
diffAction:
    bgt $s0, 0, label1
    add $s2, $s2, $s3
    j finLoop
label1: sub $s2, $s2, $s3

finLoop:
    move $v0, $s2
    jr $ra


