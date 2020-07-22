#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h> 
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char* argv[]){
    struct dirent *d; 
    DIR *ptr;  
    char first; 
    struct stat tmp;
    int init = 0; 
    char temp[1024]; 
    int m, n, t; 
    char ** str; 
    int size = 10000; 
    char path[1024]; 
    char *ptr2; 
    str = (char**) malloc(size * sizeof(char*)); 
    
    if (argc == 1){
        ptr = opendir("."); 
        if (!ptr) {
            fprintf(stderr, "Cannot open current directory!\n"); 
            exit(0); 
        }
        while ((d = readdir(ptr))) {
            first = d->d_name[0]; 
            if (first != '.'){
                stat(d->d_name, &tmp); 
                if(tmp.st_mode & S_IFDIR){
                    
                    str[init] = (char*)malloc(size*sizeof(char));
                    strcpy(str[init], d->d_name); 
                    strcat(str[init], "/"); 
                    init++; 
                }
                else if (tmp.st_mode & S_IFREG){
                    str[init] = (char*)malloc(size*sizeof(char));
                    strcpy(str[init], d->d_name); 
                    init++; 
                }
                else {
                } 
            } 
        }
    }
    else if (argc == 2){
        ptr2 = realpath(argv[1], path);
        ptr = opendir(ptr2); 
        if (!ptr) {
            fprintf(stderr, "Cannot open provided directory!\n"); 
            exit(0); 
        }
        //printf("S_IFDIR %d\n", S_IFDIR); 
        //printf("S_IFREG %d\n", S_IFREG); 
        while((d = readdir(ptr))){
            stat(d->d_name, &tmp); 
            //printf("%s\n", d->d_name); 
            //printf("%hu\n", tmp.st_mode); 
            first = d->d_name[0]; 
            if (first != '.'){  
                //if ((tmp.st_mode & S_IFMT) == S_IFDIR){
                if (S_ISDIR(tmp.st_mode)){
                    printf("Testing here\n"); 
                    str[init] = (char*)malloc(size*sizeof(char));
                    strcpy(str[init], d->d_name);
                    strcat(str[init], "/"); 
                    init++; 
                } 
                else if (tmp.st_mode & S_IFREG){
                    str[init] = (char*)malloc(size*sizeof(char));
                    strcpy(str[init], d->d_name);
                    init++; 
                }
                else{
                } 
            }
        }
    }
    else {
        fprintf(stderr, "Unrecognizable directory! \n"); 
        exit(0); 
    }

    for (m = 0; m < init; ++m){
        for (n = m+1; n < init; ++n){
            if(strcmp(str[m], str[n]) > 0){
                strcpy(temp, str[m]); 
                strcpy(str[m],str[n]); 
                strcpy(str[n], temp); 
            }
        }
    }

    for (t = 0; t < init; t++){
        printf("%s\n", str[t]); 
    }

    closedir(ptr); 
    for (t = 0; t < init; t++){
        free(str[t]); 
    }
    free(str); 
    return 0; 
}

