.data
msg1:.asciiz "Please enter number (max 20 characters): "
msg2: .asciiz "\n Please enter number to search (max 20 chars): "
msg3: .asciiz "\n please enter n:" 



.text
.globl main

main:
    li $v0,4       
    la $a0,msg1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0


    li $v0,4        #loads msg2
    la $a0,msg2
    syscall


    li $v0, 5
    syscall
    move $s1, $v0

    li $v0,4        #loads msg2
    la $a0,msg3
    syscall

    li $v0, 5
    syscall
    move $s2, $v0

    move $a0, $s0
    move $a1, $s1
    move $a2, $s2

    jal checkPattern

    move $t0, $v0

    li $v0, 1
    la $a0, ($t0)


    syscall
exit:
    li $v0,10
    syscall

checkPattern:
    addi $sp, $sp, -12
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    li $s0, 0
    li $s1, 1

    sllv $s1, $s1, $a2

    div $a0, $s1
    mfhi $s2

     li $s3, 32
     div $s3, $a2
     mflo $s3
     li $s0, 0
     li $s5, 0
             lui $s6, 0xffff
         ori $s6, $s6, 0xffff
loopPattern: beq $s0, $s3, loopPatternFinish
         div $a1, $s1
         mfhi $s4

         bne $s2, $s4, additionNotFound
         addi $s5, $s5, 1
additionNotFound:
         sllv $s6, $s6, $a2
         and $a1, $a1, $s6

         sllv $s1, $s1, $a2
         sllv $s2, $s2, $a2
         addi $s0, $s0, 1
         j loopPattern
loopPatternFinish:
         addi $v0, $s5, 0
         jr $ra