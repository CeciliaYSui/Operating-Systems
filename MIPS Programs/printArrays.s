 # ----------------------------------------------------------------------
 # Cecilia Y. Sui 
 # Print the array lists separately 
 # Allow no value put in for a specific grade 
 # print out the grades in the lists by the order they are inputted 
 # ----------------------------------------------------------------------
 
 .data
 	grades: .space 400
 	prompt: .asciiz " Enter a numeric grade (out of 100), 999 to exit data entry " 
        done:   .asciiz " End "
        separater: .asciiz ", " 
        listA:    .asciiz "\nAs List: "
        listB:    .asciiz "\nBs List: "
        listC:    .asciiz "\nCs List: "
        listD:    .asciiz "\nDs List: "
        listF:    .asciiz "\nFs List: "
        A: .word 90 
        B: .word 80  
        C: .word 70
        D: .word 60
        Aslist: .space 400   
        Bslist: .space 400  
        Cslist: .space 400   
        Dslist: .space 400    
        Fslist: .space 400
 
 
.text
        addi $s3, $0, 999 
	la, $s0, grades  # base address of grades $s0 
	add $s1, $0, $0  # initialize $s1 to be 0
	
	loop:
	    sll $t1, $s1, 2 
	    add $a0, $t1, $s0
	    addi $sp, $sp, -4
	    sw $a0, ($sp)
	    jal getgrade 
	    addi $s1, $s1, 1 # increment the loop index
	    j loop  # get elements over & over loop back 
     
	
	getgrade:	# read an integer from the keyboard. Not a leaf procedure
	        addi $sp, $sp, -4
	        sw $ra, ($sp)    # for return address $ra, so that we can use jr $ra to go back after jal
	        jal printPrompt

	        jal checkFlag # check to see if entered value is the flag 999 
	        lw $a0, 4($sp) #restore the current array position (address) into register $a0
	        lw $ra, ($sp)
	        addi $sp, $sp, 8
		sw $v0, ($a0)  #store the returned value into memory
		jr $ra
	
	printPrompt:
	        la $a0, prompt
		add $v0, $0, 4
		syscall
		jr $ra
		
	checkFlag: 		#leaf procedure		
		addi $v0, $0, 5
		syscall
		beq $v0, $s3, PrintArray 
		jr $ra
	
	
	PrintArray: # print the input array from the user input 
	        add $t0,$0,$0       # index, set to 0; keep track of the base address using $s0, but use $t0 to increment
	        add $t1, $zero, $s0 # move base address to $t1 register

	itertest:    	
	        sll $t2, $t0, 2  # sll is much faster   
	        add $t3, $t2, $t1   # address of int to print 
	        lw $a0, ($t3)    
	        addi $v0, $0,1
	        syscall
	        addi $t0, $t0, 1
	        beq $t0,$s1, PlaceInBucket
	        la $a0, separater
	        li $v0, 4
	        syscall
	        j itertest

# ----------------------------------------------------------------------
# terminate execution 
	Exit:	la $a0, done
	        addi $v0, $0, 4
	        syscall   
	        		  		         
	        # A ----------------------------------------------------------------------
	        A0:	la $a0, listA
	        	li $v0, 4
	        	syscall 
	        	la $t9, Aslist 
	        	add $a2, $sp, 16 
	        	lw $t7, ($a2)  # stack pointer
	        	li $t8, 0
	        PrintA:
	        	sll $t8, $t8, 2
	        	add $t6, $t9, $t8
	        	srl $t8, $t8, 2
	        	addi $t8, $t8, 1
	        	sw $t8, ($a2) 
	        	lw $a0, ($t6)
	        	beq $a0, $0, B0
	        	li $v0, 1
	        	syscall # print out value 
	        	la $a0, separater 
	        	li $v0, 4
	        	syscall 
	        	bne $t8, $t7, PrintA
	        
	        # B ----------------------------------------------------------------------
	        B0:	la $a0, listB
	        	li $v0, 4
	        	syscall 
	        	la $t9, Bslist 
	        	add $a2, $sp, 12
	        	lw $t7, ($a2)  # stack pointer
	        	li $t8, 0
	        PrintB:
	        	sll $t8, $t8, 2
	        	add $t6, $t9, $t8
	        	srl $t8, $t8, 2
	        	addi $t8, $t8, 1
	        	sw $t8, ($a2) 
	        	lw $a0, ($t6)
	        	beq $a0, $0, C0
	        	li $v0, 1
	        	syscall # print out value 
	        	la $a0, separater 
	        	li $v0, 4
	        	syscall 
	        	bne $t8, $t7, PrintB
	        	
	        # C ----------------------------------------------------------------------
	        C0:	la $a0, listC
	        	li $v0, 4
	        	syscall 
	        	la $t9, Cslist 
	        	add $a2, $sp, 8
	        	lw $t7, ($a2)  # stack pointer
	        	li $t8, 0
	        PrintC:
	        	sll $t8, $t8, 2
	        	add $t6, $t9, $t8
	        	srl $t8, $t8, 2
	        	addi $t8, $t8, 1
	        	sw $t8, ($a2) 
	        	lw $a0, ($t6)
	        	beq $a0, $0, D0
	        	li $v0, 1
	        	syscall # print out value 
	        	la $a0, separater 
	        	li $v0, 4
	        	syscall 
	        	bne $t8, $t7, PrintC
	        	
	        # D ----------------------------------------------------------------------
	        D0:	la $a0, listD
	        	li $v0, 4
	        	syscall 
	        	la $t9, Dslist 
	        	add $a2, $sp, 4
	        	lw $t7, ($a2)  # stack pointer
	        	li $t8, 0
	        PrintD:
	        	sll $t8, $t8, 2
	        	add $t6, $t9, $t8
	        	srl $t8, $t8, 2
	        	addi $t8, $t8, 1
	        	sw $t8, ($a2) 
	        	lw $a0, ($t6)
	        	beq $a0, $0, F0
	        	li $v0, 1
	        	syscall # print out value 
	        	la $a0, separater 
	        	li $v0, 4
	        	syscall 
	        	bne $t8, $t7, PrintD
	        
	        # F ----------------------------------------------------------------------
	        F0:	la $a0, listF
	        	li $v0, 4
	        	syscall 
	        	la $t9, Fslist 
	        	add $a2, $sp, 0 
	        	lw $t7, ($a2)  # stack pointer
	        	li $t8, 0
	        PrintF:
	        	sll $t8, $t8, 2
	        	add $t6, $t9, $t8
	        	srl $t8, $t8, 2
	        	addi $t8, $t8, 1
	        	sw $t8, ($a2) 
	        	lw $a0, ($t6)
	        	beq $a0, $0, over
	        	li $v0, 1
	        	syscall # print out value 
	        	la $a0, separater 
	        	li $v0, 4
	        	syscall 
	        	bne $t8, $t7, PrintF
	      		         
		over: 
		li $v0, 10
		syscall

# ----------------------------------------------------------------------
# Put elements in buckets 			
	PlaceInBucket:  # place elements in the ABCDF buckets 
	        add $v1,$0,$0       # index  v1 is zero 
	        add $t1, $zero, $s0 #move base address to $t1 register
                lw $s3, A # get the words corresponding to the ABCD grades 
                lw $s4, B
                lw $s5, C
                lw $s6, D
                addi $sp, $sp -20 # create space for 20 words, corresponding to the index of each sub-array
                sw $zero, ($sp)   # place 0 into all the stack locations 
		sw $zero, 4($sp)  # temporarily store the indexs 
		sw $zero, 8($sp)  # zerorize everything initially 
		sw $zero, 12($sp) # 
		sw $zero, 16($sp)  
		li $t5, 1           
		
# ----------------------------------------------------------------------
# Add more elements       
       moreEle: 
       		beq $v1,$s1, Exit   # $s1 is the count # $v1 is zero now
	        sll $t2, $v1, 2     # shift v1 & 
	        add $t3, $t2, $t1   # address of int to place in bucket; t1 is the base address 
	        lw $a0, ($t3)	    # $a0 is the grade value 
    
	  addF: slt $t4, $a0, $s6   # s6 is 60 (D); any value > 60, not add F; set less than 
	        bne $t4, $t5, addD  # t5  
                la $a1 Fslist  
                add $a2, $sp, $0   # a2 first time use, 
                jal addtolist		#
                j  moreEle 
	        
	  addD: slt $t4, $a0, $s5  # set less than s5  70 (C) 
	        bne $t4, $t5, addC
	        la $a1 Dslist
                addi $a2, $sp, 4  # Ds list is second word on
                jal addtolist
	        j  moreEle
	        
	  addC: slt $t4, $a0, $s4  # set less than s4 
	        bne $t4, $t5, addB
	        la $a1 Cslist
                addi $a2, $sp, 8
                jal addtolist
	        j  moreEle
	        
	  addB: slt $t4, $a0, $s3
	        bne $t4, $t5, addA
	        la $a1 Bslist
                add $a2, $sp, 12
                jal addtolist
	        j  moreEle
	         
	  addA:    
	        la $a1 Aslist
                add $a2, $sp, 16
                jal addtolist
	        j  moreEle
	        
	        
 	  addtolist:     
 		lw  $t7, ($a2)  # t7 is the position in stack 
		sll $t7, $t7, 2 # 
                add $t6, $a1, $t7 # address of the list 
		sw $a0, ($t6)   # 
		srl $t7, $t7, 2		
                addi, $t7, $t7, 1  	
                sw $t7, ($a2)
                addi $v1, $v1, 1
                jr $ra  
		
