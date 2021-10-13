.data
seperator: .asciiz "\n" 
line: .asciiz "\n"
result2:	.asciiz		"The items in reverse order (recursively):\n"
.text
main:
	jal create_list
	create_list:		# entry point for this utility routine

	

	addi $sp,$sp,-12 # make room on stack for 3 new items
	

	sw $s0, 8 ($sp) # push $s0 value onto stack
	

	sw $s1, 4 ($sp) # push $s1 value onto stack
	

	sw $s2, 0 ($sp) # push $s2 value onto stack
	






	addi $t1,$v0,1	# put limit value of n+1 into t1 for loop testing




	



	move $s0, $zero
	move $s0, $v0

	la $a0, result2
	li $v0, 4	
	syscall	
	move $a0, $s0	
	jal Display_Reverse_Order_Recursively
	la $a0, line #print a new line character
	li $v0, 4
	syscall
	
Display_Reverse_Order_Recursively:
	subi $sp, $sp, 8 #push (save) the list pointer and return adress parameter to the stack
	sw $a0, 0($sp)
	sw $ra, 4($sp) 
	bne $a0, $zero, recursiveCase #if list pointer is not null: recurse
	
		addi $sp, $sp, 8 #do nothing in the base case, filled the stack
		jr $ra 
	recursiveCase:
		lw $a0, 0($a0) #update to the successor
		jal Display_Reverse_Order_Recursively #recurse
		lw $a0, 0($sp)
		lw $ra, 4($sp) 
		addi $sp, $sp, 8 #push (save) the list pointer and return adress parameter to the stack
		lw $a0, 4($a0) #print the item on the top of the stack
		li $v0, 1 
		syscall
		la $a0, seperator #print a space
		li $v0, 4
		syscall
		lw $a0, 0($sp)
		jr $ra #return to the caller
