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
    exit(EXIT_SUCCESS);
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
        exit(EXIT_FAILURE);
    }

    pid_t pid[N];

    for(int i = 0; i < N; i++)
    {
        pid[i] = fork();

        switch(pid[i])
        {
            case -1: //error
                printf("Error: fork failed.\n");
                exit(EXIT_FAILURE);
                break;
            case 0: //child
                printf("PID %d: ready for work!\n", getpid());
                work();
                break;
            default: //parent
                sleep(1); // for better console output
                break;
        }
    }

    for(int i = 0; i < N; i++)
    {
        printf("Parent waits until child process with PID %d ends.\n", pid[i]);
        waitpid(pid[i], NULL, 0);
        printf("Child process with PID %d exited.\n", pid[i]);
    }

    printf("counter: %d\n", counter);

    return EXIT_SUCCESS;
}
