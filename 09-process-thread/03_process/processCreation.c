#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

int counter = 0;

void work() {
    printf("doing heavy work... \n");
    sleep(20); //simulates the "heavy" work!!

    //TODO: Add code for created processes here
    counter++;
    printf("done with %d\n", counter);
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
    //pid_t pid[N];

    pid_t pid;
    pid = fork();
    if (pid < 0){
        printf("fork failed!\n");
        exit(1);
    }
    else if (pid == 0) {
        printf("hi, I'm the child process\n");
        work();
        printf("goodbye\n");
        exit(0);
    } else {
        printf("I'm the parent and I just forked a child, pid %d\n", pid);
    }

    return EXIT_SUCCESS;
}
