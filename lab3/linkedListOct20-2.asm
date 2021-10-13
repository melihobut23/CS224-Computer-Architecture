.text
main:
# CS224 Fall 2020, Program to be used in Lab3
# October 20, 2020


	jal	createLinkedList
	move $s0,$v0 # we save head of linked list in $s0
# Linked list is pointed by $v0
	move	$a0, $v0	# Pass the linked list address in $a0
	jal 	printLinkedList
	
main_menu:
	li $v0,4
	la $a0,mainMenuMsg
	syscall
	li $v0,5
	syscall
	beq $v0,3,main_option3 #Display a linked list in reverse order with recursion
	beq $v0,4,main_option4 #Generate a copy of a linked list iteratively
	beq $v0,5,main_option5 #Generate a copy of a linked list recursively
	beq $v0,6,main_exit 
	li $v0,4
	la $a0,InvalidOption
	syscall
	j main_menu
main_option3:
	move $a0,$s0
	jal recursivePrintLinkedList
	j main_menu
main_option4:
	move $a0,$s0
	jal iterativelyGreateCopyLinkedList
	move $s1,$v0 # save head of new linked list in $s1
	li $v0,4
	la $a0,newLinkedListMsg4
	syscall
	move	$a0, $s1	# Pass the linked list address in $a0
	jal 	printLinkedList
	j main_menu
main_option5:
	move $a0,$s0
	jal recursiveGreateCopyLinkedList
	move $s1,$v0 # save head of new linked list in $s1
	li $v0,4
	la $a0,newLinkedListMsg5
	syscall
	move	$a0, $s1	# Pass the linked list address in $a0
	jal 	printLinkedList
	j main_menu
main_exit:	
# Stop. 
	li	$v0, 10
	syscall

recursivePrintLinkedList:
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)
	move $s0,$a0
	beq $s0,$zero,recursivePrintLinkedList_done
	lw $a0,0($s0) 
	beqz $a0,recursivePrintLinkedList_end_if
	jal recursivePrintLinkedList
		
recursivePrintLinkedList_end_if:
	
	lw $a0,4($s0) 
	li $v0,1
	syscall
	
	li $v0,11
	li $a0,'\n'
	syscall
recursivePrintLinkedList_done:
	lw $ra,0($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra

iterativelyGreateCopyLinkedList:
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	move $s0,$a0 
	beq $s0,$zero,iterativelyGreateCopyLinkedList_null
	li	$a0, 8 		
	li	$v0, 9
	syscall
	move $s1,$v0
	move $s2,$v0
	lw $s3,4($s0)
	sw $s3,4($s2)
iterativelyGreateCopyLinkedList_while:
	lw $s0,0($s0)
	beq $s0,$zero,iterativelyGreateCopyLinkedList_while_done
	li	$a0, 8 		
	li	$v0, 9
	syscall
	sw $v0,0($s2) # currentNd->next=newNd
	move $s2,$v0 # currentNd=newNd
	lw $s3,4($s0) # $s3 = nd->data
	sw $s3,4($s2) # currentNd->data = nd->data
	j iterativelyGreateCopyLinkedList_while	
iterativelyGreateCopyLinkedList_while_done:
	sw $zero,0($s2) # currentNd->next = null
	move $v0,$s1
	j iterativelyGreateCopyLinkedList_done
iterativelyGreateCopyLinkedList_null:
	li $v0,0	
iterativelyGreateCopyLinkedList_done:
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	addi $sp,$sp,20
	jr $ra

recursiveGreateCopyLinkedList:
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	move $s0,$a0 # $s0 = nd

	beq $s0,$zero,recursiveGreateCopyLinkedList_if
	lw $a0,0($s0) # $a0 = nd->next
	beq $a0,$zero,recursiveGreateCopyLinkedList_else_if
	# here else :)
	li	$a0, 8 		
	li	$v0, 9
	syscall
	move $s1,$v0
	lw $a0,0($s0) # $a0 = nd->next
	jal recursiveGreateCopyLinkedList
	sw $v0,0($s1) 
	lw $s2,4($s0) 
	sw $s2,4($s1) 
	move $v0,$s1
	j recursiveGreateCopyLinkedList_done
recursiveGreateCopyLinkedList_else_if:	
	li	$a0, 8 		
	li	$v0, 9
	syscall
	sw $zero,0($v0) 
	lw $s2,4($s0) 
	sw $s2,4($v0) # newNd->next = nd->data
	j recursiveGreateCopyLinkedList_done
recursiveGreateCopyLinkedList_if:
	li $v0,0	
recursiveGreateCopyLinkedList_done:
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addi $sp,$sp,16
	jr $ra
createLinkedList:

	addi	$sp, $sp, -16
	sw	$s0, 12($sp)
	sw	$s1, 8($sp)
	sw	$s2, 4($sp)
	sw	$ra, 0($sp) 	

	li $v0,4
	la $a0,createLinkedListMsg
	syscall
	li $v0,5
	syscall
	ble $v0,$zero,emptyList
	move $s2,$v0 
	li	$a0, 8
	li	$v0, 9
	syscall

	move	$s0, $v0	# $s0 points to the first and last node of the linked list.
	move	$s1, $v0	# $s1 now points to the list head.
	sw	$s2, 4($s0)	# Store the data value.
addNode:	
	

	li $v0,4
	la $a0,createLinkedListMsg
	syscall
	li $v0,5
	syscall
	ble $v0,$zero,allDone
	move $s2,$v0 # save number that entred by user in $s2
	li	$a0, 8 		
	li	$v0, 9
	syscall

	sw	$v0, 0($s0)
	move	$s0, $v0	# $s0 now points to the new node.
	sw	$s2, 4($s0)	# Store the data value.
	j	addNode
emptyList:
	li $v0,0
	j reateLinkedList_Done
allDone:
# The last node is pointed by $s0.
	sw	$zero, 0($s0)
	move	$v0, $s1	# Now $v0 points to the list head ($s1).
reateLinkedList_Done:	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s2, 4($sp)
	lw	$s1, 8($sp)
	lw	$s0, 12($sp)
	addi	$sp, $sp, 12
	
	jr	$ra
#=========================================================
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	

# $v0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s0: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	move	$a0, $s0
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

# Now consider next node.
	move	$s0, $s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
#=========================================================		
	.data
line:	.asciiz "\n --------------------------------------"

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
createLinkedListMsg:
	.asciiz "Enter number (Enter 0 or negative number to stop): "
mainMenuMsg:
	.ascii "\n\nMain menu :\n"
	.ascii "3- Display a linked list in reverse order with recursion\n"
	.ascii "4-  Generate a copy of a linked list iteratively\n"
	.ascii "5- Generate a copy of a linked list recursively\n"
	.ascii "6- quit\n"
	.asciiz "Enter selection: "
InvalidOption:
	.asciiz "Invalid Selection try again.\n"
newLinkedListMsg4:
	.asciiz "Copy of linked list after iteratively it is:\n"
newLinkedListMsg5:
	.asciiz "Copy of linked list after Recursive it is:\n"
