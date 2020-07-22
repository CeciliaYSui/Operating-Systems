 
# This is a comment ****  Introducing MIPS ********
# This program introduces MIPS highlighting the following
#       1. sections of a MIPS assembly program
#       2. registers
#       3. arithmetic
#       4. output 
#       4. syscall
  .data



        # The .asciiz assembler directive creates an ASCII string in memory terminated by
        # the null character. Note that strings are

        # surrounded by double-quotes
        
        hullo: .asciiz "Comparing" 
        # asciiz says the string terminates 
        firstless: .asciiz " - first number is less" 
        secondless: .asciiz " - second number is less " 
        equall: .ascii " - the two are equal" 
        myarray: .word 1, 1, 0, 1, 4
        myspace: .ascii ","
        
        

        msg:    .asciiz "Hello World!\n"
        label1: .asciiz "The sum is: "
        label2: .asciiz "Good job Cecilia!"
        label3: .asciiz "Else statement running \n" 
        label4: .asciiz "Endif statement running \n" 
        word1:      .word 1
        word2:      .word 2
        word3:      .word 3
        word4:      .word 4
        word5:      .word 5
        
        .text   # text section, this is the section reserved for
                # instructions

        .globl main     # declaration of the main function
                        # this is also an example of a label



 	main:          # the label main represents starting point
	
	lw $s0, word1
	lw $s1, word2
	lw $s3, word3
	lw $s5, word5
	la $s2, word2  #2
	# add $t1, $s0, $s1  #$t1 = 3
	sw  $t1,  4($s2)   # store $t1
	
	
	# else - if statement: 
	
	slt $s4, $s2, $s3  
	# if $s2 < $s3  $s4 = 1; else $s4 = 0;  
	beq $s4, 0, Else  # if equal goto Else; 
	la $s1, word1
	addu $t2, $s3, $s1   # add $s4 + $s1 store to $t2
	j    Endif   # goto Endif 
Else: 
	addi $v0, $v0,4
	la $a0, label3
	syscall 
	la $a0, label1
	syscall 
	
	#reset $v0 
	ori $v0, $zero, 1
	# print integer
	or $a0, $zero, $t2
	syscall
	
	j Exit
	
Endif:     
	

	
        #print label
        
        addi $v0, $v0,4
        la  $a0, label2  # Good job Cecilia
        syscall     
        la $a0, label1  # The sum is: 
        syscall
        
        
        
        #reset $v0 register (reset with and, or xor)
        ori $v0,$zero,1
        
        #print integer         
        or $a0, $zero, $t1     # here is another pseudoinstruction for loading the address of msg

    syscall         # code for system call to print the string
    


                    #  Before proceeding note that:

                    # pseudo instructions are not executed by MIPS processor. They are translated

                    # to MIPS commands by the simulator or assembler instead. So before proceeding, think about

                    # what the relevant arithmetic instruction would be for the li command?



                    # You guessed right, addi $v0, $zero, 4



                    # "Pseudoinstructions not only make it easier to program,

                    # they can also add clarity to the program,

                    # by making the intention of the programmer more clear."



                    # All memory structures are placed after the

                    # .data assembler directive

      


Exit:			# Label for the exit routine
ori, $v0, $zero, 10	# $v0 is a special register; if  loaded with
syscall			# value 10, it means the program should terminate
