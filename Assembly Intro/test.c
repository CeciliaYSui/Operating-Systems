#include <stdio.h>

int strlen1(char *s); 
// int strlen2(char *s); 
// int strlen3(char *s); 

int main(int argc, char *argv[])
{
    int x,y,z;
    
    x = strlen1("hello world"); 
    //y = strlen2("hello world"); 
    //z = strlen3("1234567890"); 

    printf("%d\n",x);
    return 0;
}
