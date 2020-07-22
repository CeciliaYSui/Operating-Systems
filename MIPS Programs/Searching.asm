#--------------------------------------------------------------------------------
# Cecilia Y. Sui 
# Searching for elements 
# 1. Read in an ASCII file  (done) 
# 2. Search for a char 	(done) 
# 3. Print no. of occurrences of the char  (done)
# 4. Print position of each occurrence  // FIX IT! 
# 5. Print error message if file does not exist  (done)
# 6. Print message if char not in file  (done) 
#--------------------------------------------------------------------------------

.data
	prompt:  .asciiz "Enter the character to search for: " 
	content: .asciiz "\nFile exists & content is: \n" 
	count: .asciiz "\nNumber of occurrences of the character: " 
	position: .asciiz "\nPositions (index) of occurrences of the character: "
	fileError: .asciiz "File damaged, empty or does not exist." 
	charError: .asciiz "The character does not exist in the file." 
	separater: .asciiz "   "
	
	buffer: .space 1024  # where to store the input file to a single string 
	fileName: .asciiz "./testing.txt"     # input file; must manually change each time 
	positions: .space 1024  # store the positions of the occurrences 
	
.text	
main:
#--------------------------------------------------------------------------------
# Read in the ascii file and store in buffer as a single string 
#--------------------------------------------------------------------------------
	# Open file for reading
	li $v0, 13	
	la $a0, fileName 
	li $a1, 0	
 	li $a2, 0	
 	syscall	
 	move $s1, $v0	
 	# Read the file		
 	li $v0, 14
 	move $a0, $s1  
 	la $a1, buffer  
 	li $a2, 1024  # hardcoded buffer length 
 	syscall
 	# Close the file 
 	li $v0, 16
 	move $a0, $s1 
 	syscall 
	
#--------------------------------------------------------------------------------
# print prompt for input char & read in char & store it 
#--------------------------------------------------------------------------------
Input: 
	li $v0, 4
	la $a0, prompt 
	syscall 
	li $v0, 12		# char input read in 
	syscall 
	move $s0, $v0 		# store char to search for in $s0

#--------------------------------------------------------------------------------
# Search for the required char in buffer 
# $s0 is the required char 
#--------------------------------------------------------------------------------
	la $s1, buffer 	# load the buffer string into $s1 
	li $t0, 0 	# iterator / length
	li $t1, 0	# count 
	la $s7, positions # store output 
	add $s7, $0, $0   # set base address to 0 
	
	Loop: 
		add $s2, $s1, $t0 	# $s2 = buffer[i]
		lb $s3, 0($s2) 		# load char into $s3 
		beq $s3, $0, Print 	# if end, exit out the loop
		addi $t0, $t0, 1	# i++
		add $t2, $0, $0  	# set $t2 = 0
		sll $t2, $t0, 2		# * 4 (0-4-8...) 
		beq $s3, $s0, AddCount
		j Loop 
		
	Print: 
		beq $t0, $0, Error
		# Print the file 
		li $v0, 4
		la $a0, content 
		syscall 
		li $v0, 4
		la $a0, buffer 
		syscall 
		beq $t1, $0, NotFound	# char not in file 
		li $v0, 4
		la $a0, count
		syscall 
		move $a0, $t1
		li $v0, 1
		syscall 
		
	PrintPositions: 
		li $v0, 4
		la $a0, position	# print string 
		syscall 
		la $a0, positions	# set array 
		move $a1, $t1		# set $a1 = no. of counts  
		li $t6, 1		# iterator 
		
		PrintArray:
			add $t4, $0, $0		# set $t4 to 0 
			sll $t4, $t6, 2 	# * 4 position wise 
			lb $a0, positions ($t4) 
			li $v0, 1
			syscall
			la $a0, separater 
			li $v0, 4
			syscall 
			addi $t6, $t6, 1
			slt $t5, $t1, $t6
			beq $t5, $0, PrintArray
					
#--------------------------------------------------------------------------------
# Terminate program 
#--------------------------------------------------------------------------------							
Exit: 
	li $v0, 10 		# finish & exit 
	syscall 

#--------------------------------------------------------------------------------
# other called instructions 
#--------------------------------------------------------------------------------
AddCount: 
	addi $t1, $t1, 1	# count++ 
	sb  $t0, positions($t2)   # store the position index into array positions 
	j Loop

NotFound: 
	li $v0, 4
	la $a0, charError
	syscall 
	j Exit

Error: 
	li $v0, 4
	la $a0, fileError
	syscall 
	j Exit