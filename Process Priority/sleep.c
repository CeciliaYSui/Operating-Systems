#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
    int ticks = 50; 

    if (argc > 2){
        printf(1, "usage: sleep [ticks]\n"); 
        exit(); 
    }

    if (argc == 2){
        ticks = atoi(argv[1]); 
    }

    sleep(ticks); 
    exit(); 
}