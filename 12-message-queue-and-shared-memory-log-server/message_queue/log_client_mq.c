#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

key_t MESSAGE_QUEUE_KEY   = 0x4242; //key of the message queue
#define MAX_MESSAGE_LEN     (1024)  //max length of messages

//structure for messages
//TODO: define message struct


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

        //TODO: prepare message

        //TODO: send message to message queue
        
    }

    return EXIT_SUCCESS;
}
