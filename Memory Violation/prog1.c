#ifdef __pie__
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#else
#include "types.h"
#include "user.h"
#endif


int global = 923591;  // random large integer 


void displayMem(char *p, int size){
    int i, j;
    for (i = 0; i < size; i += 16){
        #ifdef __pie__
        printf("%p:", p); 
        #else
        printf(1, "%p:", p);
        #endif
        for (j = 0; j < 16; j ++){
            #ifdef __pie__
            printf(" %x", (*(p++)&0xFF)); 
            #else
            printf(1, " %x", (*(p++)&0xFF)); 
            #endif
        }
        #ifdef __pie__
        printf("\n"); 
        #else
        printf(1, "\n"); 
        #endif
    }
}


void fillMem(char *p, int size, char value){
    int i, j; 
    char *ptr = p; 
    for (i = 0; i < size; i += 16){
        for (j = 0; j < 16; j++){
            *(p++) = value; 
        }
    }
    displayMem(ptr, size); 
}


int main(int argc, char * argv[]){
    // try to handle input differently // FIX HERE 
    // displayMem(*argv, 256); 
    char * heap = malloc(1); 
    #ifdef __pie__
    char * eptr;  // linux use only 
    #endif

    if (argc < 3){
        #ifdef __pie__
        printf("Usage: ...\n"); 
        #else
        printf(1, "Usage: ... \n");
        #endif 
        free(heap); 
        #ifdef __pie__
        return 0; 
        #else
        exit();
        #endif
    }    
    else if (argc == 3){
        // 1 argument provided [read / write]
        if (*argv[1] == 'r'){
            // reading mode
            int i; 
            switch (*argv[2]){
                //
                case '1':
                    displayMem((char *) 0x0, 256); 
                    break;
                case '2':
                    #ifdef __pie__
                    displayMem((char *) 0xffffff00, 256);
                    #else
                    displayMem((char *) 0xaf00, 256);
                    #endif
                    break; 
                case '3':
                    displayMem((char *)&main, 256);
                    break;
                case '4':
                    displayMem((char *)&global, 256); // data section
                    break;
                case '5':
                    displayMem(heap, 256); // heap section
                    break;
                case '6':
                    displayMem(*argv, 256); // stack section
                    break;
                case '8':
                    #ifdef __pie__
                    // 2 ^ 15
                    for (i = 0; i < 32768; i+=128){
                        displayMem(((char*)*argv)+i, 16); 
                    }
                    #else
                    for (i = 0 ; i < 4096; i+=32){
                        displayMem(((char*) 0xA100)+i, 16); 
                    }
                    #endif
                    break;
                case '9':
                    #ifdef __pie__
                    for (i = 0; i < 32768; i+=128){
                        displayMem(((char*)&global)-i, 16); 
                    }
                    #else
                    for (i=0; i< 4096; i+=32){
                        displayMem(((char*)&global)-i, 16); 
                    }
                    #endif
                    break;
                default:
                    #ifdef __pie__
                    printf("Usage: ...\n"); 
                    #else
                    printf(1, "Usage: ... \n");
                    #endif 
                    free(heap); 
                    #ifdef __pie__
                    return 0; 
                    #else
                    exit();
                    #endif
                    break; 
            }
        }
    }
    else if (argc == 4){
        if((*argv[1] == 'r') && (*argv[2] == '7')){
            #ifdef __pie__
            displayMem((char *)strtol(argv[3], &eptr, 0), 256); 
            #else
            displayMem((char*)atoi(argv[3]), 256); 
            #endif
        }
        else if (*argv[1] =='w'){
            int i; 
            switch (*argv[2]){
                case '1':
                    fillMem((char *) 0x0, 256, *argv[3]); 
                    // displayMem((char *) 0x0, 256); 
                    break;
                case '2':
                    #ifdef __pie__
                    fillMem((char *) 0xffffff00, 256, *argv[3]); 
                    // displayMem((char *) 0xffffff00, 256);
                    #else
                    fillMem((char *) 0xaf00, 256, *argv[3]);
                    //displayMem((char *) 0xaf00, 256);
                    #endif
                    break; 
                case '3':
                    fillMem((char *) &main, 256, *argv[3]);
                    // displayMem((char *)&main, 256);
                    break;
                case '4':
                    fillMem((char *) &global, 256, *argv[3]);
                    //displayMem((char *)&global, 256); // data section
                    break;
                case '5':
                    fillMem(heap, 256, *argv[3]);
                    //displayMem(heap, 256); // heap section
                    break;
                case '6':
                    fillMem(*argv, 256, *argv[3]);
                    //displayMem(*argv, 256); // stack section
                    break;
                case '8':
                    #ifdef __pie__
                    // 2 ^ 15
                    for (i = 0; i < 32768; i+=128){
                        fillMem(((char*)*argv)+i, 16, *argv[3]);
                        //displayMem(((char*)*argv)+i, 16); 
                    }
                    #else
                    for (i = 0 ; i < 4096; i+=32){
                        fillMem(((char*) 0xA100)+i, 16, *argv[3]);
                        //displayMem(((char*) 0xA100)+i, 16); 
                    }
                    #endif
                    break;
                case '9':
                    #ifdef __pie__
                    for (i = 0; i < 32768; i+=128){
                        fillMem(((char*)&global)-i, 16, *argv[3]);
                        //displayMem(((char*)&global)-i, 16); 
                    }
                    #else
                    for (i=0; i< 4096; i+=32){
                        fillMem(((char*)&global)-i, 16, *argv[3]);
                        //displayMem(((char*))&global)-i, 16); 
                    }
                    #endif
                    break;
                default:
                    #ifdef __pie__
                    printf("Usage: ...\n"); 
                    #else
                    printf(1, "Usage: ... \n");
                    #endif 
                    free(heap); 
                    #ifdef __pie__
                    return 0; 
                    #else
                    exit();
                    #endif
                    break; 
            }
        }
    }



    #ifdef __pie__
    return 0; 
    #else
    exit();
    #endif
}