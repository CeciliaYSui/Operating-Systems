#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> 
#include <errno.h>
#include <string.h> 
#include <unistd.h>
#include <ctype.h> 
#include<sys/types.h> 
#include<sys/wait.h> 


int main(int argc, char* argv[]) {
    int i, a; 
    FILE * fp; 
    char *line = NULL; 
    char *tmp; 
    size_t len = 0; 
    ssize_t read; 
    char** pathList; 
    char pathName[100]; 
    char** commands; 
    int cnt = 1; 
    bool flag = true; 
    
    // store paths 
    pathList = malloc(100 * sizeof(char*)); 
    pathList[0] = pathName; 
    commands = malloc(1000 * sizeof(char*)); 

    if (argc == 1){
        fprintf(stderr, "usage: my-bash [file ...]\n"); 
        exit(0); 
    }

    fp = fopen(argv[1], "r"); 
    if (fp){
        while ((read = getline(&line, &len, fp) != -1)) {
            // skip blank lines 
            if (strlen(line) == 1){
                continue; 
            }
            tmp = strtok(line, " \n"); 
            i = 0; 
            while(tmp != NULL){
                commands[i] = tmp; 
                i++; 
                // skip comments 
                if (!strcmp(tmp, "#")){
                    break; 
                }
                // exit 
                if (!strcmp(tmp, "exit")){
                    exit(0); 
                }
                // path 
                if (!strcmp(tmp, "path")){
                    if (flag){
                        for (i=0; i<cnt; ++i){
                            printf("%s ", pathList[i]); 
                        }
                    }
                }
                else {
                    strcpy(pathName, "/bin/"); 
                    pathList[0] = strcat(pathName, tmp); 
                    printf("%s\n", pathList[0]); 
                    // check for executable 
                    a = access(pathList[0], X_OK); 
                        if (a == -1){
                            printf("ERRNO: %d\n", errno); 
                        }                
                    // create child process 
                    pid_t pid = fork(); 
                    if (pid == -1){
                        printf("Fork Failed.\n"); 
                    }
                    else if (pid == 0){
                        execv(pathList[0], NULL); 
                    }
                    else {
                        wait(NULL); 
                    }
                }
                tmp = strtok(NULL, " \n"); 
            }
        }
    }
    else {
        if (errno == EEXIST) {
            fprintf(stderr, "Cannot open file \n"); 
        }
        else{
            fprintf(stderr, "File does not exist \n"); 
        }
        exit(0); 
    }
    fclose(fp); 
    if (line){
        free(line);
    }
    return 0; 
}