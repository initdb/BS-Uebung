#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

key_t MESSAGE_QUEUE_KEY   = 0x4242; //key of the message queue
#define MAX_MESSAGE_LEN     (1024)  //max length of messages

//priority for messages
typedef enum {
    HIGH   = 1
   ,NORMAL = 2
   ,LOW    = 3
} priority_t;

//structure for messages
typedef struct {
    long priority;
    char message[MAX_MESSAGE_LEN];
} message_t;


int main() {
    //open the message queue
    int message_queue_id = msgget(MESSAGE_QUEUE_KEY, IPC_PRIVATE);
    if(message_queue_id < 0) {
        printf("Error: can't open message queue!\n");
        exit(EXIT_FAILURE);
    }

    //client endless loop
    while(1) {
        //fetch user input from console (stdin)
        char buffer[MAX_MESSAGE_LEN];
        fgets(buffer, MAX_MESSAGE_LEN-1, stdin);

        if(strcmp("\\quit\n", buffer) == 0) { //quit if user types: \quit
            break;
        }

        //prepare message
        message_t message;

        message.priority = NORMAL;
        strncpy(message.message, buffer, sizeof(message.message));

        //send message to message queue
        int size = msgsnd(message_queue_id, &message, MAX_MESSAGE_LEN-1, 0);
        if(size < 0){
            printf("Error at writing message to message queue!\n");
            exit(EXIT_FAILURE);
        }
    }

    return EXIT_SUCCESS;
}
