#ifdef __pie__
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#else
#include "types.h"
#include "user.h"
#endif


int global = 923591;  // random large integer 

//-----------------------------------------------------------------
// Display Memory from a location for a given no. of bytes
//-----------------------------------------------------------------
void displayMem(char *ptr, int size){
    int i, j;
    for (i = 0; i < size; i += 16){
        #ifdef __pie__
        printf("%p:", ptr); 
        for (j = 0; j < 16; j++){
            printf(" %02X", (*(ptr++)&0xFF));
        }
        printf("\n");
        #else
        printf(1, "%p:", ptr);
        for (j = 0; j < 16; j++){
            printf(1, " %x", (*(ptr++)&0xFF));
        }
        printf(1, "\n");
        #endif
    }
}

//-----------------------------------------------------------------
// write in memory from a location for a given no. of bytes
//-----------------------------------------------------------------
void fillMem(char *ptr, int size, char fill){
    int i, j; 
    char *p = ptr; 
    for (i = 0; i < size; i += 16){
        for (j = 0; j < 16; j++){
            *(ptr++) = fill; 
        }
    }
    displayMem(p, size); 
}


int main(int argc, char * argv[]){
    char *heap = malloc(100);  // to access heap memory
    #ifdef __pie__
    char *lptr;  // linux use only
    #endif

    if (argc < 3){
        #ifdef __pie__
        printf("Usage: r [1-9] [epsilon|specified address]\n");
        printf("       w [1-9] [filling character|specified address]\n");
        #else
        printf(1, "Usage: r [1-9] [epsilon|specified address]\n");
        printf(1, "       w [1-9] [filling character|specified address]\n");
        #endif 
        free(heap); 
    }    
    else if (argc == 3){
        if (*argv[1] == 'r'){
            int i; 
            switch (*argv[2]){
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
                    displayMem((char *)&global, 256); // data
                    break;
                case '5':
                    displayMem(heap, 256); // heap
                    break;
                case '6':
                    displayMem(*argv, 256); // stack
                    break;
                case '8':
                    // probing downward 
                    #ifdef __pie__
                    // 2 ^ 16
                    for (i = 0; i < 65536; i+=64){
                        displayMem(((char*)*argv)+i, 16); 
                    }
                    #else
                    // 2 ^ 13
                    for (i = 0 ; i < 8192; i+=64){
                        displayMem(((char*) 0xA100)+i, 16); 
                    }
                    #endif
                    break;
                case '9':
                    // probing upward 
                    #ifdef __pie__
                    for (i = 0; i < 65536; i+=64){
                        displayMem(((char*)&global)-i, 16); 
                    }
                    #else
                    for (i=0; i< 8192; i+=32){
                        displayMem(((char*)&global)-i, 16); 
                    }
                    #endif
                    break;
                default:
                    #ifdef __pie__
                    printf("Usage: r [1-9] [epsilon|specified address]\n");
                    printf("       w [1-9] [filling character|specified address]\n");
                    #else
                    printf(1, "Usage: r [1-9] [epsilon|specified address]\n");
                    printf(1, "       w [1-9] [filling character|specified address]\n");
                    #endif 
                    free(heap); 
            }
        }
    }
    else if (argc == 4){
        if((*argv[1] == 'r') && (*argv[2] == '7')){
            #ifdef __pie__
            displayMem((char *)strtol(argv[3], &lptr, 0), 256); 
            #else
            displayMem((char*)atoi(argv[3]), 256); 
            #endif
        }
        else if (*argv[1] =='w'){
            int i; 
            switch (*argv[2]){
                case '1':
                    fillMem((char *) 0x0, 256, *argv[3]); 
                    break;
                case '2':
                    #ifdef __pie__
                    fillMem((char *) 0xffffff00, 256, *argv[3]); 
                    #else
                    fillMem((char *) 0xaf00, 256, *argv[3]);
                    #endif
                    break; 
                case '3':
                    fillMem((char *) &main, 256, *argv[3]);
                    break;
                case '4':
                    fillMem((char *) &global, 256, *argv[3]);
                    break;
                case '5':
                    fillMem(heap, 256, *argv[3]);
                    break;
                case '6':
                    fillMem(*argv, 256, *argv[3]);
                    break;
                case '7':
                    #ifdef __pie__
                    fillMem((char *)strtol(argv[3], &lptr, 0), 256, *argv[3]); 
                    #else
                    fillMem((char*)atoi(argv[3]), 256, *argv[3]); 
                    #endif
                    break; 
                case '8':
                    // probing downward / forward
                    #ifdef __pie__
                    // 2 ^ 15
                    for (i = 0; i < 32768; i+=64){
                        fillMem(((char*)*argv)+i, 16, *argv[3]);
                    }
                    #else
                    for (i = 0 ; i < 4096; i+=32){
                        fillMem(((char*) 0xA100)+i, 16, *argv[3]);
                    }
                    #endif
                    break;
                case '9':
                    // probing upward / backward
                    #ifdef __pie__
                    for (i = 0; i < 32768; i+=64){
                        fillMem(((char*)&global)-i, 16, *argv[3]);
                    }
                    #else
                    for (i=0; i< 4096; i+=32){
                        fillMem(((char*)&global)-i, 16, *argv[3]);
                    }
                    #endif
                    break;
                default:
                    #ifdef __pie__
                    printf("Usage: r [1-9] [epsilon|specified address]\n");
                    printf("       w [1-9] [filling character|specified address]\n");
                    #else
                    printf(1, "Usage: r [1-9] [epsilon|specified address]\n");
                    printf(1, "       w [1-9] [filling character|specified address]\n");
                    #endif 
                    free(heap); 
            }
        }
    }
    #ifdef __pie__
    return 0; 
    #else
    exit();
    #endif
}