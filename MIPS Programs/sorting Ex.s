# ----------------------------------------------------------------------
# Cecilia Y. Sui 
# Program to implement sorting 
# 1. repeatedly ask for user input (stop when the size is reached)
# 2. Store input elements in integer array 
# 3. Print the entered list & the total number of elements in the array 
# 4. Sort the list in increasing order 
# 5. Print the sorted list 
# ----------------------------------------------------------------------

.data
	sortedArray: .space 400   
	inputArray:  .space 400 
	size: .asciiz "Enter size of the array: "
	prompt: .asciiz "Enter an integer: "
	final: .asciiz "\nSorted: "
	separater:  .ascii ", "


.text
main:
	la $a0, size  # put the string address in $a0 register                      
	add $v0, $0, 4  # put 4 in the $v0 register for print 
	syscall  # print out size string 

	li $v0,5   # read in an integer, put 5 in $v0 register to read the input int 
	syscall	   # read in the integer from user input 

	move $s1, $v0   # here $v0 holds the input int value for size, & move the value from $v0 to $s1                     
	sub $s1, $s1, 1     # decrement the size by 1, each time we run the code, so that it will stop when done             
	
	la $s7, inputArray
	add $s7, $0, $0   # set the base address to 0 
	
	la $s6, sortedArray 
	add $s6, $0, $0   # set the base address to 0 

addint:
	la $a0, prompt    #  put the string address in $a0 register                 
	add $v0, $0, 4     # put 4 in $v0 to print the string 
	syscall		  # print the string 

	li $v0, 5        # put 5 in $v0 to read an integer from user input     
	syscall		 # read the int (stored in $V0) 

	move $t3,$v0      # store the user input int in $t3 	                            
	add $t1,$0,$0       # set $t1 to 0 
	sll $t1,$t0,2        # $t1 = $t0 * 4 (shift left logical)      0-4-8-...               

	sw $t3, sortedArray ($t1)   # store value in $t3 into array($t1) memory location 
	sw $t3, inputArray ($t1)  # store value in input array 
	           
	addi $t0,$t0,1          # increment $t0 by 1             
	slt $t1, $s1, $t0         # if $s1 < $t0, $t1 = 1; else, $t1 = 0.             
	beq $t1, $0, addint    # if $t1 = 0, do it again :) 

	
	la $a0,sortedArray                        
	addi $a1,$s1,1                      

	jal bubble_sort                            

	la $a0, final 
	li $v0, 4
	syscall        # print the final string 

	la $t0,sortedArray                        
	li $t1,0    
	
	la $t7, inputArray
	li $t6, 0                        


# ----------------------------------------------------------------------
# Print & Exit 

printInput: 

# 

printSorted:
lw $a0,0($t0)                       
li $v0,1
syscall

la $a0, separater
li $v0, 4
syscall 

addi $t0,$t0,4                      
addi $t1,$t1,1                      
slt $t2,$s1,$t1                     
beq $t2,$zero,printSorted
                 

exit: 
	li $v0,10       # exit (terminate execution)                
	syscall

# ----------------------------------------------------------------------




bubble_sort:
	li $t0,0                            

loop1:
addi $t0,$t0,1                      
bgt $t0,$a1,end                  
add $t1,$a1,$zero                   

loop2:
bge $t0,$t1,loop1                  
subi $t1,$t1,1                      
sll $t4, $t1, 2                     
subi $t3, $t4, 4                    

add $t4,$t4,$a0                     
add $t3,$t3,$a0                     
lw $t5,0($t4)
lw $t6,0($t3)

swap:
bgt $t5,$t6,loop2                   
sw $t5,0($t3)                       
sw $t6,0($t4)
j loop2

end:
jr $ra
