.data 
	hullo: .asciiz "Comparing" 
        # asciiz says the string terminates 
        firstless: .asciiz " - first number is less" 
        secondless: .asciiz " - second number is less " 
        equal: .ascii " - the two are equal" 
        myarray: .word 6,1,9,1,4
        myspace: .ascii ","


.text 
	main:
	
	la $s0, myarray   # put the address of myarray to $s0 
	lw $t0, 0($s0)  # grab the first element in the array 0($s0)  -- copied to t0
	lw $t1, 4($s0)  # 4 steps (1 word, 4 bytes) grab the second element 
	# sw $t0, 4($s0)  # store word into array 
	
	la $a0, hullo 
	ori $v0, $0, 4
	syscall 
	
	or $a0, $t0, $zero 
	ori $v0, $0, 1
	syscall 
	
	la $a0, myspace 
	ori $v0, $0, 4
	syscall 
	
	or $a0, $t1, $zero
	ori $v0, $0, 1
	syscall 
	
	beq $t0, $t1, equalcode  
	slt $t3, $t0, $t1  
	ori $t4, $0, 1
	beq $t4, $t3, firstlesscode 
	la $a0, secondless
	ori $v0, $0, 4
	syscall 
	j Exit
	

	
	firstlesscode:  la $a0, firstless
			ori $v0, $0, 4
			syscall 
			j Exit 
			
	equalcode: 	la $a0, equal
			ori $v0, $0, 4
			syscall 
			j Exit 
	
	
Exit: 
	ori, $v0, $zero, 10
	syscall 
	