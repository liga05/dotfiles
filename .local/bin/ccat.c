#!/usr/local/bin/tcc -run
#include <stdio.h>
 
int main(int argc, char *argv[]) {
    if(argc != 2) {
        puts("usage: ccat filename");
    }
    else {
        FILE *file = fopen(argv[1], "r");
        if(file == 0) {
            puts("Could not open file or file doesn't exist");
        }
        else {
            int x;
            while((x = fgetc(file)) != EOF) {
                printf("%c", x);
            }
            fclose(file);
        }
    }
}
