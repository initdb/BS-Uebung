#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

int counter = 0;

void* work()
{
    printf("doing heavy work... \n");
    sleep(20); //simulates the "heavy" work!!
    
    counter++;

    return NULL;
}

int main(int argc, char** argv)
{
    int N = 0;

    if(argc == 2)
    {
        N = atoi(argv[1]);
    }
    else
    {
        printf("Usage: %s N \n", argv[0]);
        exit(1);
    }

    pthread_t pth[N];
    int thread_create_state;
    int thread_exit_state;

    for(int i = 0; i < N; i++)
    {
        // create threads, which executes work
        thread_create_state = pthread_create(&pth[i], NULL, &work, NULL);

        if(thread_create_state != 0)
        {
            fprintf(stderr, "failed creating thread.\n");
            exit(EXIT_FAILURE);
        }
    }

    for(int i = 0; i < N; i++)
    {
        // join thread, waits until the thread has finished
        thread_exit_state = pthread_join(pth[i], NULL);

        if(thread_exit_state != 0)
        {
            printf("thread exited with failure %d.\n", thread_exit_state);
        }

        printf("child thread exited with TID %lu exited.\n", pth[i]);
    }

    printf("counter: %d\n", counter);

    return EXIT_SUCCESS;
}
