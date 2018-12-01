#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>

void sig_interrupt_common(int signal)
{
    const int MAX_LEN = 64;
    char name[MAX_LEN];

    switch (signal) {
        case 1:
            sprintf(name, "SIGHUP");
            break;
        case 2:
            sprintf(name, "SIGINT");
            break;
        case 3:
            sprintf(name, "SIGQUIT");
            break;
        case 15:
            sprintf(name, "SIGTERM");
            break;
        default:
            sprintf(name, "unknown");
    }
    printf("Got signal %s\n", name);
}

void sig_interrupt_abort(int signal)
{
    printf("Got signal for aborting, exiting ...\n");
    exit(EXIT_SUCCESS);
}

void sig_interrupt_alarm(int signal)
{
    printf("Alarm triggered!\n");
}

int main(int argc, char** argv)
{
    //Register the signal handlers
    signal(SIGHUP, sig_interrupt_common);
    signal(SIGINT, sig_interrupt_common);
    signal(SIGQUIT, sig_interrupt_common);
    signal(SIGTERM, sig_interrupt_common);
    signal(SIGABRT, sig_interrupt_abort);
    signal(SIGALRM, sig_interrupt_alarm);

    //Process the parameters
    if (argc == 1){
        int secondsToSleep = 90 * 60; //Default value 90 minutes
        while(1) {
            //sleep returns if a signal is caught, the return value are the remaining seconds to sleep
            secondsToSleep = sleep(secondsToSleep);
            if (secondsToSleep == 0) {
                //The process slept long enough
                break;
            }
        }
        printf("signal_example returned succesful after 90 minutes\n");
    } else if (argc == 2 && (strcmp(argv[1], "--abort") == 0)){
        raise(SIGABRT);
    } else if (argc == 3 && (strcmp(argv[1], "--alarm") == 0) && (atoi(argv[2]) > 0 )) {
        int secondsToSleep = atoi(argv[2]);
        alarm(secondsToSleep);
        pause();
    } else {
        printf("Usage: %s [--abort | --alarm N] \n", argv[0]);
        exit(1);
    }

    printf("%s exits main() now!\n", argv[0]);
    return EXIT_SUCCESS;
}
