#include "user.h"

int main(int argc, char *argv[]){

    setpriority(2, 20); 

    setpriority(-10, 10); 

    exit();
}