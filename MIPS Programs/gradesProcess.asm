# Dr Alfa Nyandoro 09/28/2018
# Program to demonstrate 
# 1. passing arguments to, and returning values from functions (procedures)
# 2. proper use convention for saved registers ($s0, $s1, etc), argument registers ($a0 - $a3) and return value
#    registers ($v0-$v1) and $ra register    

# The program reads a set of grades - and stores them in memory and then goes through the list 
# New 4 sublists for As, Bs, Cs and Other

 .data
 	#grades: .space  400
 	# runtime array - $v0 <- 9, syscall. $v0 will have base
 	# address of the runtime array.
 	
 	grades: .space 400
 	# 400 bytes --> 100 word 
 	prompt: .asciiz " Enter a numeric grade (out of 100), 999 to exit data entry " 
 	# use address ... register 
        done:   .asciiz " End "
        separater: 	.ascii ", " 
        A: .word 90 # definition of grades ABCD; 
        B: .word 80 # 
        C: .word 70
        D: .word 60
        
        Aslist: .space 400   # 400 bytes space 
        Bslist: .space 400   # place the grades in the lists  
        Cslist: .space 400   # convention to start at 400 
        Dslist: .space 400   # la $Aslist; need starting point of the array address & an index for each ABCDF 
        Fslist: .space 400
 
# align directive ? 
 
.text
        #Get the size of array at runtime
        
        
        addi $s3, $0, 999 # use flag 999 to terminate progam 
        # ask user how many elements to enter
        
	la, $s0, grades
	# store the grades 
	
	add $s1,$0, $0 #initialize loop index to 0 
	# $s1 increments by 1 each loop 
	
	loop:
	    sll $t1, $s1, 2 #create word offset for array, not index offset 
	    # add 4 each time here, shift left logical 
	    # $t1 is the result of the shift, index $s1 increments by 1
	    
	    add $a0, $t1, $s0
	    # $t1 is the shifted index by word  
	    # $s0 is the base address of array 
	    # $a0 is the stored new position of the array  
	    
	    addi $sp, $sp, -4
	    # stack pointer $sp create room on the stack 
	    # $sp pointing top at the stack, & create room by -4 or -8 or -... 
	    # stack grows downwards 
	    # +4 is popping elements  
	    # we do not remove the stack information, but only overwrite it 
	    # so when we go back next time, the info is still there, but overwrite it when we need it 
	    
	    sw $a0, ($sp)
	    # store word into the stack 
	    # store $a0 the new position in array to stack 
	     
	    jal getgrade  # jump & link; then come back 
	    # read integer from keyboard 
	    # return to the line after the jal, 4 bytes more than current address 
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
	                        #leaf procedure
	        la $a0, prompt
	        # put the string address in $a0 register 
		add $v0, $0, 4
		# put 4 in $v0 register to print 
		syscall
		# print for syscall 
		jr $ra
		
	checkFlag: 		#leaf procedure		
		addi $v0, $0, 5
		syscall
		beq $v0, $s3, PrintArray # Check if integer is 999
		jr $ra
	
	
	PrintArray: # print the input array from the user input 
	        add $t0,$0,$0       # index, set to 0; keep track of the base address using $s0, but use $t0 to increment
	        add $t1, $zero, $s0 #move base address to $t1 register
	        # Print Lists
	        
	        
	        
	itertest:    	
	        sll $t2, $t0, 2  # sll is much faster   
	        add $t3, $t2, $t1   #address of int to print 
	        lw $a0, ($t3)    
	        addi $v0, $0,1
	        syscall
	        addi $t0, $t0, 1
	        beq $t0,$s1, PlaceInBucket
	        la $a0, separater
	        addi $v0, $zero, 4
	        syscall
	        j itertest
         #case statement for A, B, C D and others grades
            
	        
	Exit:	la $a0, done
	        addi $v0, $0, 4
	        syscall    
		addi $v0, $0, 10
		syscall
		
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
                
		addi $t5,$0, 1 #to test for equality ? 
		
	
       moreEle: beq $v1,$s1, Exit   # $s1 is the count 
       				    # $v1 is zero now
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
	        
	        
 addtolist:     lw  $t7, ($a2)  # t7 is the position in stack 
		sll $t7, $t7, 2 # 
                add $t6, $a1, $t7 # address of the list 
		sw $a0, ($t6)   # 
		srl $t7, $t7, 2		
                addi, $t7, $t7, 1  	
                sw $t7, ($a2)
                addi $v1, $v1, 1
                jr $ra  
		
		

PrintAslist: 
	# 

PrintBslist:

PrintCslist:

PrintDslist:

PrintFslist: 
	
		
		
		
	
			
  
