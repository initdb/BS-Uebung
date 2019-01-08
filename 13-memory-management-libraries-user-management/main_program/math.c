#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <supermath.h>

void print_help_and_exit_on_invalid_parameter(char** argv){
    printf("Usage: %s x {+|-} y \n", argv[0]);
    exit(EXIT_FAILURE);
}

int main(int argc, char** argv) {
    int invalid_parameter = 0;
    int z = 0;

    if(argc == 4) {
       int x = atoi(argv[1]);
       int y = atoi(argv[3]);
       
       if(strcmp("+", argv[2]) == 0) {
           z = my_add(x, y);
       } else if(strcmp("-", argv[2]) == 0) {
           z = my_sub(x, y);
       } else {
           print_help_and_exit_on_invalid_parameter(argv);
       }
    } else {
        print_help_and_exit_on_invalid_parameter(argv);
    }

    printf("The result is: %d \n", z);
    return EXIT_SUCCESS;
}
