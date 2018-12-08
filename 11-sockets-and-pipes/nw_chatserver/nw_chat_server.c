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
 * nw_chat_server.c
 * A simple chatserver where clients can connect and send messages to each other
 */


#define MAX_CLIENTS         (128)  //Max clients
const int MAX_MESSAGE_LEN = 1024;  //Max length of messages
const int PORT            = 15000; //Network port

//Mutex for locking the access to the client array
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int client_count = 0; //Count of clients

//Structure for managing the client
typedef struct client_s {
    struct sockaddr_in address;
    int socket;
    int id;
} client_t;

//Array with all clients, access has to be threadsafe (mutex!)
client_t* clients[128];

//This function handles the communication with each client
void* client_communication(void* argument){
    client_t* client = (client_t*)argument;

    //Insert the new client into the client array
    pthread_mutex_lock(&mutex); //P
        int client_index = -1;
        for(int i = 0; i < MAX_CLIENTS; ++i){ //find free place in clients array
            if(clients[i] == NULL){
                client_index = i;
                break;
            }
        }
        clients[client_index] = client;
        client_count++;
    pthread_mutex_unlock(&mutex); //V

    //Now we can receive and send messages
    while(1) {
        //receive data
        char received_message[MAX_MESSAGE_LEN];
        ssize_t size = recv(client->socket, &received_message, MAX_MESSAGE_LEN-1, 0);
        if(size <= 0) {
            break; //no data received or connection closed
        } else {
            //the message has to be properly 0-terminated
            received_message[size] = '\0';
            printf("Message from ID %d: %s", client->id, received_message);
        }

        //Add the client id to the message
        char message_to_send[MAX_MESSAGE_LEN];
        sprintf(message_to_send, "ID %d: ", client->id);
        strcat(message_to_send, received_message);

        //Now send the message to all other clients:
        pthread_mutex_lock(&mutex); //P
        for(int i = 0; i < MAX_CLIENTS; i++) {
            if(clients[i] != NULL && (clients[i]->id != client->id)) {
                send(clients[i]->socket, &message_to_send, MAX_MESSAGE_LEN -1, 0);
            }
        }
        pthread_mutex_unlock(&mutex); //V
    }

    printf("Client with ID %d disconnected\n", client->id);

    //Close and free all ressources for this client
    pthread_mutex_lock(&mutex); //P
        //close client socket
        close(client->socket);
        
        client_count--;
        
        //delete client structure
        clients[client_index] = NULL;
        free(client);
        client = NULL;
    pthread_mutex_unlock(&mutex); //V
    
    return NULL;
}

int main() {
    //Init the clients array with NULL
    for(int i = 0; i < MAX_CLIENTS; i++) {
        clients[i] = NULL;
    }

    //create socket for incomming connections
    int network_socket = socket(AF_INET, SOCK_STREAM, 0);
    if(network_socket < 0){
        printf("Error: can't create socket!\n");
        exit(EXIT_FAILURE);
    }

    //configure socket to accept multiple connections
    const int accept_multiple_connections = 1;
    setsockopt( network_socket, SOL_SOCKET, SO_REUSEADDR, &accept_multiple_connections, sizeof(int));

    //bind socket to port
    struct sockaddr_in address;
    address.sin_family      = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port        = htons(PORT); //convert values between host and network byte order 

    int bind_result = bind(network_socket, (struct sockaddr*) &address, sizeof(address));
    if(bind_result != 0) {
        printf("Error: can't bind socket\n");
        exit(EXIT_FAILURE);
    }

    //create a queue for connections
    int MAX_PENDING_CONNECTIONS = 5;
    int listen_result = listen(network_socket, MAX_PENDING_CONNECTIONS);
    if(listen_result != 0) {
        printf("Error: can't create listen queue\n");
        exit(EXIT_FAILURE);
    }

    //server endless loop
    int client_id = 0; //a counter for client ids
    while(1){
        //wait for new connections
        socklen_t addrlen = sizeof(struct sockaddr_in);
        int client_socket = accept(network_socket, (struct sockaddr*) &address, &addrlen);
        if(client_socket < 0) {
            printf("Error at accept!\n");
            exit(EXIT_FAILURE);
        }

        //check if MAX_CLIENTS is not reached
        if(client_count > MAX_CLIENTS) {
            printf("Max clients reached, rejecting!\n");
            close(client_socket);
            continue;
        }

        //Prepare the client structure
        client_t* client = (client_t*)malloc(sizeof(client_t));
        client->address = address;
        client->socket  = client_socket;
        client->id      = client_id++;
        
        //Start the thread
        printf("Connection to client with id %d established!\n", client->id);
        pthread_t thread_id;
        pthread_create(&thread_id, NULL, &client_communication, (void*) client);
    }

    return EXIT_SUCCESS; //should never be reached
}
