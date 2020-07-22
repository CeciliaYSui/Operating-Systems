#include <stdio.h>
#include <stdlib.h>

void f(int *p, int n){
    while (*p++);
    *p = n; 
}

int main()
{
    int x[5] = {1,2,3};
    f(x,7);
    f(x+2,9);
    for (int i=0; i<5; i++){
        printf("%d ", x[i]); 
    }
    return 0; 
}