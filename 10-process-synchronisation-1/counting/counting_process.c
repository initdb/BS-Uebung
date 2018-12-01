#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

static int semid;

int main () {
    //TODO: You may test if the semaphore already exist (use semget(...)). If not you create it.


    //Main task: Loop 2000000 times and add 1 to the counter inside the loop
    for (int i = 0; i < 2000000; ++i) {
        //TODO: You have to place the P/V operations here...
        //      But remember, the Linux API does not provide P/V directly.


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
    }

    printf("Finished!\n");

    return EXIT_SUCCESS;
}
