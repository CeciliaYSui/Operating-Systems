#include <stdio.h>
#include <stdlib.h>

long cache[1000] = {0,1};
int limit = 1;
int uninitialized[10000];

long fib(int n) 
{
    if (n < 0) 
        return 0; /* really an error */
    while (limit < n) {
        limit++;
        cache[limit] = cache[limit-1]+cache[limit-2];
    }
    return cache[n];
}

int main(int argc,char **argv)
{
    int i;
    long *list;

    for (i=0; i<10; i++)
        printf("%d: %ld\n",i,fib(i));
    for (i=10; i<100; i+=10)
        printf("%d: %ld\n",i,fib(i));

    list = (long *)malloc(sizeof(long)*1000);
    for (i=0; i<1000; i++)
        list[i] = fib(i);
    free(list);

    return 0;
}
