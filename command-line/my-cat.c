#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
    int i; 
    FILE * fp; 
    char buffer[1000]; 

    if (argc == 1){
        fprintf(stderr, "usage: my-cat file ..."); 
        exit(0); 
    }

    for (i=1; i<argc; i++){
        fp = fopen(argv[i], "r"); 
        if (!fp){
            fprintf(stderr, "Cannot open file! \"%s\"\n", argv[i]); 
        }
        else {
            while(fgets(buffer,1000,fp)){
                printf("%s", buffer); 
            } 
            fclose(fp); 
        }
    }
    return 0; 
}
