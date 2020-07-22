#include "types.h"
#include "stat.h"
#include "user.h"

int global = 0; 

int main(int argc, char *argv[])
{
    if (argc != 2){
        printf(1, "usage: cpu <string>\n"); 
        exit();
    }
    while (1){
        printf(0, "%s: [%p]=%d\n", argv[1], &global, global); 
        global = global + 1; 
        sleep(50); // approximately 1 second
    }
    
    exit();
}