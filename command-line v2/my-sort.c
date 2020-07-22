#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include <errno.h>


int main(int argc, char* argv[]){
    int i = 0; 
    FILE * fp; 
    char ** output; 
    int size = 10000; 
    char line[1024]; 
    int cnt = 0; 
    char temp[1024]; 
    int m, n, t; 

    output = (char**) malloc(size * sizeof(char*));  

    if (argc == 1){
        while(fgets(line, sizeof(line), stdin)){
            output[cnt] = (char*)malloc(size*sizeof(char)); 
            strcpy(output[cnt], line); 
            cnt++; 
        }
        //strcat(output[cnt-1], "\n"); 
    }
    else{
        for (i=1; i<argc; i++){
            fp = fopen(argv[i], "r"); 
            if (fp){ 
                while(fgets(line, sizeof(line), fp)){
                    output[cnt] = (char*)malloc(size*sizeof(char)); 
                    strcpy(output[cnt], line); 
                    cnt++; 
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
            //strcat(output[cnt-1], "\n"); 
        }
    }

    for (m = 0; m < cnt; m++){
        for (n = m+1; n < cnt; n++){
            if(strcmp(output[m], output[n]) > 0){
                strcpy(temp, output[m]); 
                strcpy(output[m],output[n]); 
                strcpy(output[n], temp); 
            }
        }
    }

    for (t = 0; t < cnt; t++){
        printf("%s", output[t]); 
    }

    for (t = 0; t < cnt; t++){
        free(output[t]); 
    }
    free(output); 

    return 0; 
}