#include <stdio.h>

int boo();
int bar(int a,int b);
int baz(int *p,int n);

int g = 31;
int d[] = {1,2,3,4,5};

int main(int argc, char *argv[])
{
    int x,y,z;
    
    x = boo();
    y = bar(3,7);
    z = baz(d,5);

    printf("%d %d %d\n",x,y,z);
    return 0;
}