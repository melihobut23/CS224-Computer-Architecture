# February 14, 2020 Example Program: Not done in class
# Illustrates the method/function concept in MIPS 
# Write a method/function to find the maximum of two numbers.
# max: method name, it is like any label.
# max expects to have its paramters in argument registers. Why: Professional Convention.
# In this case we have two arguments so pass them in $a0, and $a1 argument registers.
# max returns result in $v0 register. Why: Professional Convention.
# jal: Use jump and link to branch to max
# jr: Use jump register to to go back to the location that follows jal.

 	lw	$a0, a
 	lw	$a1, b
 	jal	max	
 # jal: Branches to max and stores the address of the following  instruction (li) in $ra.
 # $vo conatins the result of the method max.
	
 	 li	$v0, 10 # stop execution
 	 syscall 
#===================================================================================
max:# The beginning of the subprogram/method:
	add	$t0, $zero, $a0 # move first argument in $a0 to $t0
	add	$t1, $zero, $a1 # move second argument in $a1 to $t1
# Use $t2 to store the maximum of the arguments.
	add	$t2, $zero, $t0
	bgt	$t2, $t1, done
	add	$t2, $zero, $t1
done:	
# Move $t2 to $v0: it is the register used to return the result of a function.
	add	$v0, $zero, $t2
	
# Go back to the caller: The instruction that follows jal.
	jr	$ra
#====================================================================================
# All variables are at global scope.	
# The following variables are use to initialize the arguments of the max method.
	.data
a:	.word	1
b:	.word 	2
	

	