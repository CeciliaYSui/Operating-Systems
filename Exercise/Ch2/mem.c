#include <unistd.h> 
#include <stdio.h>
#include <stdlib.h>
#include "common.h"
#include <assert.h>

int 
main(int argc, char *argv[]){
    // 
    int *p = malloc(sizeof(int));       // allocate memory 
    assert(p != NULL);  
    printf("(%d) address pointed to by p: %p\n", getpid(), p); // print out address of the memory 
    *p = 0; // put number 0 in the 1st slot of the newly allocated memory 
    int a = 10; 
    while (a > 0){
        *p = *p + 1; // increment value stored at the address held in p 
        printf("(%d) p: %d\n", getpid(), *p); 
        a = a - 1; 
    } 
    return 0; 
}