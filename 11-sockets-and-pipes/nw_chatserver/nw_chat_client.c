#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>

/*
 * nw_chat_client.c
 * The client for a simple chat server
 */

const int MAX_MESSAGE_LEN = 1024;  //Max length of messages
const int PORT            = 15000; //Network port

int network_socket = -1;

//this function receives all incoming messages, it should run inside a second thread
void* receiver_thread() {
    //endless loop to receive messages from the server
    while(1) {
        char received_message[MAX_MESSAGE_LEN];
        //TODO: receive messages from the server
        ssize_t size = -1;
        
        if(size <= 0) {
            break; //no data received or connection closed
        } else {
            //the message has to be properly 0-terminated
            received_message[size] = '\0';
            printf("Received: %s", received_message);
        }
    }
    return NULL;
}

int main(int argc, char** argv) {
    //check if a parameter for the IP address exists
    char* server_ip = NULL;
    if(argc < 2) {
        printf("Usage: %s <serveraddress>\n", *argv);
        exit(EXIT_FAILURE);
    } else {
        server_ip = argv[1];
    }

    //TODO: Create the socket


    //TODO: Set the IP address and the port of the server (The server listens on port 15000)
    //Hint:
    // - use "inet_aton(...)" to convert internet host address to binary form
    // - use "htons(...)" convert values between host and network byte order
    struct sockaddr_in address;

    //TODO: Connect to server


    //start the thread to receive messages from the server
    pthread_t thread_id = -1;
    pthread_create(&thread_id, NULL, &receiver_thread, NULL);

    //send input from stdin as message
    char message[MAX_MESSAGE_LEN];
    while(1) {
        //fetch user input from console (stdin)
        fgets(message, MAX_MESSAGE_LEN, stdin);
        
        if(strcmp(message, "\\quit\n") == 0) {
            //close the network socket:
            // - similar to close(network_socket)
            // - but the recv() in the receiver_thread exits with: size == 0
            shutdown(network_socket, SHUT_RDWR);
            break;
        }

        //TODO: send message to the server
        
    }

    //wait until the receive thread exits
    pthread_join(thread_id, NULL);

    return EXIT_SUCCESS;
}
