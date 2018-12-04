#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/sem.h>

const int   P_OP = -1;
const int   V_OP = 1;
const int   PERM = 0644;
const key_t KEY  = 565423;

static int semid;

void create_semaphore()
{
    // create semaphore
    semid = semget(KEY, 1, IPC_CREAT | IPC_EXCL | PERM);
    if(semid < 0)
    {
        perror("Error when creating the semaphore...\n");
        exit(EXIT_FAILURE);
    }

    // init semaphore with 1
    if(semctl(semid, 0, SETVAL, (int) 1) == -1)
    {
        perror("Error can't initialize semaphore...\n");
    }
}

void delete_semaphore()
{
    if(semctl(semid, 0, IPC_RMID) == -1)
    {
        perror("Error can't delete semaphore...\n");
        exit(EXIT_FAILURE);
    }
}

void semaphore_operation(int sid, int op)
{
    struct sembuf semaphore;
    semaphore.sem_op = op;  // P = -1; V = 1
    semaphore.sem_flg = 0;  // no flags needed

    if(semop(sid, &semaphore, 1) == 1)
    {
        perror("semop failed\n");
        exit(EXIT_FAILURE);
    }
}

int main () {
    //TODO: You may test if the semaphore already exist (use semget(...)). If not you create it.
    semid = semget(KEY, 1, IPC_PRIVATE);
    if(semid < 0)
    {
        create_semaphore();
    }

    //Main task: Loop 2000000 times and add 1 to the counter inside the loop
    for (int i = 0; i < 2000000; ++i)
    {
        //TODO: You have to place the P/V operations here...
        //      But remember, the Linux API does not provide P/V directly.
        semaphore_operation(semid, P_OP);

        //Open the file
        int file = open("counter", O_RDWR);
        if (file == -1) {
            printf("Could not open file, exiting!\n");
            exit(1);
        }

        //Read the number
        const int MAX_LEN = 64;
        char number[MAX_LEN];
        read(file, &number, sizeof(number));
        
        //Convert the string into an integer
        int counter = atoi(number);
        counter++;

        //Write the new number into the counter
        sprintf(number, "%d\n", counter);
        lseek(file, 0, 0);
        write(file, &number, strlen(number) + 1);
        
        //Close the file
        close (file);

        semaphore_operation(semid, V_OP);
    }

    printf("Finished!\n");

    return EXIT_SUCCESS;
}
