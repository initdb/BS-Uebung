#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/file.h>

static int semid;

int main ()
{
    //Main task: Loop 2000000 times and add 1 to the counter inside the loop
    for (int i = 0; i < 200000; ++i)
    {
        //TODO: You have to place the P/V operations here...
        //      But remember, the Linux API does not provide P/V directly.
        int fd = open("counter.lck", O_RDWR);
        if(fd < 0)
        {
            perror("no such file...\n");
            exit(EXIT_FAILURE);
        }
        flock(fd, LOCK_EX);

        //Open the file
        int file = open("counter", O_RDWR);
        if (file == -1)
        {
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

        flock(fd, LOCK_UN);
        close(fd);
    }

    printf("Finished!\n");

    return EXIT_SUCCESS;
}
