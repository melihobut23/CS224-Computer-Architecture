.data
result:		.word 0
prompt1:	.asciiz "Enter a number: "
prompt2:	.asciiz "The result is: "
msg1:		.asciiz "Enter a pattern to search"
msg2:		.asciiz	"Enter a input to search the pattern"
msg3:		.asciiz "Enter number of digit to search pattern"
menu:		.asciiz "\nChoose an operation from the menu:\n1. Check pattern\n2.Recursive Sum\n3. Reverse order\n3. Enter 0 to exit\n"

.text 
	.globl __main 
__main:
  	  	
Menu:	
	la $a0, menu #menu
	li $v0, 4
	syscall	

	li $v0, 5 # read input
	syscall
	
	beq $v0, 1, callcheckPattern1 
  	beq $v0, 2, callRecursiveSummation     
  	#beq $v0,3, calldisplayReverseorder
  	#beq $v0,4, callduplicateListIterative
  	#beq $v0,4, callduplicateListRecursive		       
  	beq $v0, 0, exit
  	
  	j Menu
  	
callcheckPattern1:
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
    jr $ra

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
     
loopPattern: 
        beq $s0, $s3, loopPatternFinish
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
         
callRecursiveSummation:
	la $a0, prompt1 # Enter a number:
	li $v0, 4
	syscall	
	
	li $v0, 5 # read input
	syscall

	move $a0, $v0  # move the number to $a0 as parameter
	jal  sum # call the subprogram
	sw   $v0, result        # save the output to result
	
	la $a0, prompt2 # The result is
	li $v0, 4
	syscall	
	
	lw $a0, result #  print result
	li $v0, 1 
	syscall

  	
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	

# recursiveSummation subprogram
#------------------------------------------------
sum : 
addi $sp, $sp,-8  #stack for retrieving values
sw $ra,0($sp)     #store pc addresss to base address of stack
sw $a0,4($sp)     #store user input in stack
seq $s0,$a0,0     #compare user input is 0 or not
beq $s0,0,recurse #if input is not 0 then call recursive function
li $v0,0          #otherwie return 0
jr $ra            #return functioncall

#Recursive function

recurse:
addi $a0,$a0,-1 #subtract user input 1
jal sum #call sum function
lw $ra,0($sp) #load value of PC from sp
lw $a0,4($sp) #load user input from sp
addi $sp,$sp,8 #clear sp
add $v0,$a0,$v0 #sum result in v0
jr $ra 
	 
	
