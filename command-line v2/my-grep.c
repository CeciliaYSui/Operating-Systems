#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include <errno.h>

int main(int argc, char* argv[]){
    int i; 
    FILE * fp; 
    char buffer[1000]; 
    char *pattern = argv[1]; 

    if (argc == 1){
        fprintf(stderr, "usage: my-grep searchterm [file ...]"); 
        exit(0); 
    }
    else if (argc == 2){
        while(fgets(buffer,sizeof(buffer), stdin)){
            if(strstr(buffer, pattern)){
                printf("%s", buffer); 
            }
        }
        exit(0); 
    }

    for (i=2; i<argc; i++){
        fp = fopen(argv[i], "r"); 
        if (fp){
            while(fgets(buffer,sizeof(buffer),fp)){
                if (strstr(buffer, pattern)){
                    printf("%s", buffer); 
                }
                else{
                    continue; 
                }
            } 
            fclose(fp); 
        }
        else {
            if (errno == EEXIST){
                fprintf(stderr, "Cannot open file! \"%s\"\n", argv[i]); 
            }
            else{
                fprintf(stderr, "File does not exist! \"%s\"\n", argv[i]); 
            }
            exit(0); 
        }
    }
    return 0; 
}
