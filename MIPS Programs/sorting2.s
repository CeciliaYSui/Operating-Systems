    .text
    .globl main
main:       la  $a0, Array             # sets the base address of the array to $a0
loop:       lw  $t0, 0($a0)             # sets $t0 to the current element in array
            lw  $t1, 4($a0)         # sets $t1 to the next element in array
            blt $t1, $t0, swap      # if the following value is greater, swap them
            addi    $a0, $a0, 4     # advance the array to start at the next location from last time
            j   loop                  # jump back to loop so we can compare next two elements

swap:       sw  $t0, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
            sw  $t1, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
            li  $a0, 0                 # resets the value of $a0 back to zero so we can start from beginning of array
            j   loop                  # jump back to the loop so we can go through and find next swap

            .data

Array:      .word   14, 12, 13, 5, 9, 11, 3, 6, 7, 10, 2, 4, 8, 1 
