#include <stdio.h>
#include <stdlib.h>

int global;
extern char _end;

int main(int argc, char *argv[])
{
    char *p = malloc(1);
    printf("main=%p\n",&main);
    printf("global=%p\n",&global);
    printf("_end=%p\n",&_end);
    printf("heap=%p\n",p);
    printf("stack=%p\n",&argc);

    return 0;
}
