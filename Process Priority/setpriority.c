#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){

    if (argc != 3) {
        printf(1, "usage: setpriority [pid] [number]\n"); 
        exit(); 
    }

    if (argc == 3){
        setpriority(atoi(argv[1]), atoi(argv[2])); 
    }

    exit(); 
}