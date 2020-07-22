
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
        # indentations tell the relationships (like in Python) 
        # assembly programming :) 

        # surrounded by double-quotes

        msg:    .asciiz "Hello World!\n"
        # the z after ascii allows the print function to terminate after the quote 
        # without the z, ascii just prints it on and on 
        label1: .asciiz "The sum is: "
        word1:      .word 5
        # a word is 32 bits (4 bytes) 
        word2:      .word 6
        word3:      .word 0
        
        .text   # text section, this is the section reserved for
                # instructions 

        .globl main     # declaration of the main function
                        # this is also an example of a label



 	main:          # the label main represents starting point
	
	lw $s0, word1
	# load word (lw) --> get the data into register s0 
	lw $s1, word2
	la $s2, word2
	# load address (la) 
	add $t1, $s0, $s1
	# add data in s0 and s1, and put the result into register t1 
	# initially everything in the registers are zeros (but sp - starting point) 
	sw  $t1,  4($s2)
	
        #print label
        
        addi $v0, $v0,4
        la  $a0, label1
        syscall     
        # system call: system take care of other jobs -- let the system do something 
        # v0 - the general register to put syscall etc. 
        
        
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
