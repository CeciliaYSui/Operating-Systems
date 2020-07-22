#include "types.h"
#include "stat.h"
#include "user.h"

int global;
extern char _end; 

int main(int argc, char *argv[])
{
    char *p = malloc(1); 
    printf(0, "main=%p\n", &main); 
    printf(0, "global=%p\n", &global); 
    printf(0, "_end=%p\n", &_end); 
    printf(0, "heap=%p\n", p); 
    printf(0, "stack=%p\n", &argc); 
    
    exit();
}