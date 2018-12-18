#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>

const key_t SHM_KEY  = 0x424242; //Key of the shared memory segment
const key_t SEM_KEY  = 0x424242; //Key of the semaphore

/*
 * This Linux semaphore consists of two semaphores
 * - ID 0: READY_TO_WRITE - Initialized with 1
 * - ID 1: READY_TO_READ  - Initialized with 0
 */
const int READY_TO_WRITE = 0;
const int READY_TO_READ  = 1;

const int P_OP           = -1;       //P operation: subtract 1
const int V_OP           =  1;       //V operation: adds 1
const int PERM           = 0644;     //Permission to the semaphore

#define MAX_SHM_LEN        (1024)    // length of shared memory

int global_semid         = 0;

void fetch_semaphore() {
    global_semid = semget(SEM_KEY, 0, IPC_PRIVATE);
    if(global_semid < 0){ //if not exists
        perror("Error when creating the semaphore ...\n");
        exit(EXIT_FAILURE);
    }
}

void semaphore_operation(int sid, int sem_num, int op) { //does a semaphore operation P/V
    struct sembuf semaphore;
    semaphore.sem_op  = op; //P = -1; V = 1
    semaphore.sem_flg = 0;  //no flags needed
    semaphore.sem_num = sem_num;  //semaphore with index sem_num
    
    if(semop(sid, &semaphore, 1) == -1) {
        perror("semop failed");
        exit (EXIT_FAILURE);
    }
}

void P(int semid, int sem_num) {
    semaphore_operation(semid, sem_num, P_OP);
}

void V(int semid, int sem_num) {
    semaphore_operation(semid, sem_num, V_OP);
}

int main() {
    //fetch the semaphores
    fetch_semaphore();

    //TODO: get existing shared memory
    
    
    //TODO: attach the shared memory
    

    //TODO: let buffer point the shared mem address as a char pointer
    char* buffer = NULL;
    
    //client endless loop
    while(1) {
        char message[MAX_SHM_LEN];
        fgets(message, MAX_SHM_LEN, stdin);

        if(strcmp("\\quit\n", message) == 0) { //quit if user types: \quit
            break;
        }

        //TODO: use P/V and copy the message into the shared memory
        //Hint: For copy use strcpy()
        
    }

    //TODO detach shared memory
    


    return EXIT_SUCCESS;
}
