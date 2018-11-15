#include <stdlib.h>        //EXIT_SUCCESS
#include <stdio.h>         //printf
#include "mathfunctions.h" //int_add

int main(int argc, char const *argv[])
{
    int a = 3; int b = 4;

#ifdef USE_SPECIAL_ADD
    printf("use special add\n");
    int result = int_add(a, b);
#else
    int result = a + b;
#endif

    printf("%d + %d = %d\n", a, b, result);
    return EXIT_SUCCESS;
}