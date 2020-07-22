// valgrind --leak-check=full --track-origin=yes
// gcc -g 
// ctrl-d is the end of file marker 

#include <stdio.h> 
#include <stdlib.h> 


int main(){
    int *p, *q; 
    int i = 0; 
    int cnt = 0; 
    int max = 1; 
    p = malloc(max*sizeof(int));  
    // use & to get the address of p[i] and store val into it 
    //while (scanf("%d", &p[i]) != EOF)
    //    i++; 

    while (scanf("%d", p+cnt) != EOF) {
        cnt++; 
        if (cnt == max){
            max *= 2; 
            // realloc 
            // double the size of the already allocated if exceed 
            q = malloc(max*sizeof(int)); 
            for (i=0; i<cnt; i++){
                q[i] = p[i]; 
            }
            free(p);  // must free(p) before reassignning ptr p to q 
            p = q;  // let p point to the same address as q 
        }
    }

    for (i = 0; i < cnt; i++) {
        printf("%d ", p[i]); 
    }

    free(p); 
    return 0; 
}
