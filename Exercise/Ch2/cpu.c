#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <assert.h>
#include "common.h"

int main(int argc, char *argv[]){
    // 
    if (argc != 2){
        fprintf(stderr, "usage: cpu <string> \n"); 
        exit(1); 
    }
    char *str = argv[1]; 
    int a = 10; 
    while (a > 0){
        // Spin(1); 
        printf("%s\n", str); 
        a -= 1; 
    }
    return 0; 
}