#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> 
#include <errno.h>
#include <string.h> 
#include <unistd.h>
#include <ctype.h> 
#include <sys/types.h> 
#include <sys/wait.h> 


int main(int argc, char* argv[]) {
    int i, j, k, a; 
    FILE * fp; 
    char *line = NULL; 
    char *tmp; 
    size_t len = 0; 
    ssize_t read; 
    char** pathList; 
    //char pathName[100]; 
    char** commands; 
    int pathCnt = 1; 
    pid_t pid; 
    
    // store paths 
    pathList = malloc(1000 * sizeof(char*)); 
    pathList[0] = "/bin"; 
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
                // skip comments 
                if (!strcmp(tmp, "#")){
                    break; 
                }
                commands[i] = tmp; 
                i++; 
                tmp = strtok(NULL, " \n"); 
            }
            // built-in exit command
            if (!strcmp(commands[0], "exit")){
                exit(0); 
            }
            // built-in path command 
            if (!strcmp(commands[0], "path")){
                // print current paths 
                if (i == 1){
                    printf("\ncurrent paths "); 
                    for(j=0; j<pathCnt; j++){
                        printf(": %s ", pathList[j]); 
                    }
                }
                // replace paths 
                else {
                    for(k=0; k<i-1; k++){
                        pathList[k] = commands[k+1]; 
                        printf("%s ", pathList[k]); 
                        pathCnt = k+1; 
                    }
                }
                continue; 
            }
            // external commands: 
            // with no arguments
            if (i==1){
                for (j=0; j<pathCnt; j++){
                    strcpy(tmp, pathList[j]); 
                    strcat(tmp, "/"); 
                    strcat(tmp, commands[0]); 
                    printf("%s\n", tmp); 
                    a = access(tmp, X_OK); 
                    if (a == -1){
                        printf("ERRNO: %d\n", errno); 
                        exit(0); 
                    }
                    else {
                        pid = fork(); 
                        if (pid == -1){
                            printf("Fork failed. \n"); 
                        }
                        else if (pid == 0){
                            execv(tmp, NULL); 
                        }
                        else {
                            wait(NULL); 
                        }
                    }
                }
            }
            // external commands with arguments 
            else { 
                for (j=0; j<pathCnt; j++){
                    strcpy(tmp, pathList[j]); 
                    strcat(tmp, "/"); 
                    strcat(tmp, commands[0]); 
                    printf("%s\n", tmp); 
                    a = access(tmp, X_OK); 
                    if (a == -1){
                        printf("ERRNO: %d\n", errno); 
                        exit(0); 
                    }
                    else {
                        pid = fork(); 
                        if (pid == -1){
                            printf("Fork failed. \n"); 
                        }
                        else if (pid == 0){
                            execv(tmp, commands++); 
                        }
                        else {
                            wait(NULL); 
                        }
                    }
                }
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