#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h> 
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char* argv[]){
    struct dirent *d; 
    DIR *ptr;  
    char first; 
    struct stat tmp;
    int line = 1000, s = 1000; 
    char str[line][s]; 
    int init = 0; 
    char temp[1000]; 
    int m, n, t; 
    
    // default current directory 
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
                strcpy(str[init], d->d_name); 
                if(tmp.st_mode & S_IFDIR){
                    // is directory 
                    strcpy(str[init], d->d_name); 
                    strcat(str[init], "/"); 
                    init++; 
                }
                else if (tmp.st_mode & S_IFREG){
                    // is file
                    strcpy(str[init], d->d_name); 
                    init++; 
                }
                else {
                } 
            } 
        }
    }
    else if (argc == 2){
        ptr = opendir(argv[1]); 
        if (!ptr) {
            fprintf(stderr, "Cannot open current directory!\n"); 
            exit(0); 
        }
        while((d = readdir(ptr))){
            stat(d->d_name, &tmp); 
            first = d->d_name[0]; 
            if (first != '.'){
                //strcpy(str[init], d->d_name);
                if (tmp.st_mode & S_IFDIR){
                    strcpy(str[init], d->d_name);
                    strcat(str[init], "/"); 
                    init++; 
                } 
                else if (tmp.st_mode & S_IFREG){
                    strcpy(str[init], d->d_name);
                    init++; 
                }
                else{
                    // 
                } 
            }
        }
    }
    else {
        fprintf(stderr, "Unrecognizable directory! \n"); 
        exit(0); 
    }

    // sorting stage
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
    return 0; 
}
