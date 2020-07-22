#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf("usage: cpu <string>\n");
        return 0;
    }
    while (1) {
        sleep(1);
        printf("%s\n",argv[1]);
    }
    return 0;
}
