#include <stdio.h>
#include <stdlib.h>
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
const char* LOGFILE      = "log_server_sm.log"; //path of logfile

int global_semid         = 0;

void create_new_semaphore() {
    global_semid = semget(SEM_KEY, 0, IPC_PRIVATE);
    if(global_semid >= 0){ //delete it if it exists!
        semctl(global_semid, 0, IPC_RMID);
    }

    //create semaphore with length 2
    global_semid = semget(SEM_KEY, 2, IPC_CREAT | IPC_EXCL | PERM);
    if(global_semid < 0) {
        perror("Error when creating the semaphore ...\n");
        exit(EXIT_FAILURE);
    }

    //init semaphore READY_TO_WRITE with value 1
    if(semctl(global_semid, READY_TO_WRITE, SETVAL, (int) 1) == -1) {
        perror("Error can't initialise READY_TO_WRITE semaphore...\n");
        exit(EXIT_FAILURE);
    }

    //init semaphore READY_TO_READ with value 0
    if(semctl(global_semid, READY_TO_READ, SETVAL, (int) 0) == -1) {
        perror("Error can't initialise READY_TO_READ semaphore...\n");
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
    //create the semaphores
    create_new_semaphore();

    //create the shared memory
    int shared_mem_id = shmget(SHM_KEY, MAX_SHM_LEN, PERM | IPC_CREAT);
    if(shared_mem_id < 0) {
        perror("Error: can't create shared memory!\n");
        exit(EXIT_FAILURE);
    }

    //attach the shared memory
    void* shared_mem_address = shmat(shared_mem_id, NULL, SHM_RDONLY);
    if(shared_mem_address == (void*)-1) {
        perror("Error: can't attach shared memory!\n");
        exit(EXIT_FAILURE);
    }

    //create and open the logfile
    FILE* logfile = fopen(LOGFILE, "a"); //open in append mode (a)
    if(logfile == NULL) {
        perror("Error: can't open logfile!\n");
        exit(EXIT_FAILURE);
    }

    //let buffer point the shared mem address as a char pointer
    char* buffer = (char*)shared_mem_address;

    //server endless loop
    while(1) {
        //wait that someone writes something into the shared memory
        P(global_semid, READY_TO_READ);

            //print received message on console
            printf("message: %s\n", buffer);

            //write message to log
            fputs(buffer, logfile);
            fflush(logfile); //make sure it is flushed right now

        //signal a client can now write into the shared memory
        V(global_semid, READY_TO_WRITE);
    }

    //close logfile
    fclose(logfile);

    //detach shared memory
    shmdt(shared_mem_address);
    buffer = NULL;
    shared_mem_address = NULL;

    //delete shared memory
    shmctl(shared_mem_id, IPC_RMID, NULL);

    return EXIT_SUCCESS; //should never be reached
}
