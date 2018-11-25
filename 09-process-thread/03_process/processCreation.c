#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

int counter = 0;

void work()
{
    printf("doing heavy work... \n");
    sleep(20); //simulates the "heavy" work!!

    counter++;
    printf("done with %d\n", counter);
}

int main(int argc, char** argv)
{
    int N = 0;

    //Get the number of processes which should be created
    if(argc == 2)
    {
        N = atoi(argv[1]);
    } 
    else
    {
        printf("Usage: %s N\n", argv[0]);
        exit(1);
    }

    pid_t pid[N];

    while(counter <= N)
    {
        //pid_t pid;
        pid[counter] = fork();
        work();
    }

    printf("counter: %d\n", counter);

    return EXIT_SUCCESS;
}
