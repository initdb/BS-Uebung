#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

key_t MESSAGE_QUEUE_KEY   = 0x4242; //key of the message queue
#define MAX_MESSAGE_LEN     (1024)  //max length of messages
const int PERM            = 0666;   //give the created message queue all rights
const char* LOGFILE       = "log_server_mq.log"; //path of logfile

//structure for messages
typedef struct {
    long priority;
    char message[MAX_MESSAGE_LEN];
} message_t;

int main() {
    //create the message queue
    int message_queue_id = msgget(MESSAGE_QUEUE_KEY, PERM | IPC_CREAT);
    if(message_queue_id < 0) {
        printf("Error: can't create message queue!\n");
        exit(EXIT_FAILURE);
    }

    //create and open the logfile
    FILE* logfile = fopen(LOGFILE, "a"); //open in append mode (a)
    if(logfile == NULL) {
        printf("Error: can't open logfile: %s!\n", LOGFILE);
        exit(EXIT_FAILURE);
    }

    //server endless loop
    while(1) {
        //receive message
        message_t message;
        const int FETCH_FLAG = 0; //0 = fetch in FIFO order
        ssize_t size = msgrcv(message_queue_id, &message, MAX_MESSAGE_LEN-1, FETCH_FLAG, 0);
        if(size < 0) {
            printf("Error: can't receive message;");
            exit(EXIT_FAILURE);
        }

        //print received message on console
        message.message[size] = '\0';
        printf("message (prio: %ld): %s\n", message.priority, message.message);

        //write message to log
        fputs(message.message, logfile);
        fflush(logfile); //make sure it is flushed right now
    } //should never be left

    //remove message queue
    msgctl(message_queue_id, IPC_RMID, NULL);

    //close logfile
    fclose(logfile);

    return EXIT_SUCCESS; //should never be reached
}
