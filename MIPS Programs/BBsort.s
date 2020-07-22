.data 
	myarray: .word 5,4,3,2,1
	sortedarray: .asciiz "the array is sorted" 

.text 
	main:
	la $s0, myarray 
	lw $t0, 0($s0)   #a[0]
	lw $t1, 4($s0)   #a[1] 
	
	slt $t2, $t0, $t1  # $t2 is 1 if $t0 < $t1, thus = 1, if in right order 
	# t2 = 0, we need to swap 
	beq $t2, 0, swap1
	
	swap1: 
		sw $t0, 4($s0) 
		sw $t1, 0($s0) 
	
	
	lw $t0, 4($s0)   #a[1]
	lw $t1, 8($s0)   #a[2] 
	slt $t2, $t0, $t1
	beq $t2, 0, swap2

	swap2: 
		sw $t0, 8($s0) 
		sw $t1, 4($s0) 
	
	
		
		

Exit: 
	ori $v0, $0, 10
	syscall 