#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

int counter = 0;

void work() {
    sleep(20); //simulates the "heavy" work!!

    //TODO: Add code for created processes here
    
}

int main(int argc, char** argv){

    int N = 0;

    //Get the number of processes which should be created
    if(argc == 2){
        N = atoi(argv[1]);
    } else {
        printf("Usage: %s N\n", argv[0]);
        exit(1);
    }

    //TODO: Write your code here
    pid_t pid[N];

    return EXIT_SUCCESS;
}
