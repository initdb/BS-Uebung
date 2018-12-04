#!/bin/bash

#####################################################
# 10.5 signal handling                              #
#####################################################
# send SIGUP to signal_example
# kill -1 6073
killall -1 signal_example

# send SIGINT to signal_example
# ctrl+c
# kill -2 6073
killall -2 signal_example

# send SIGQUIT to signal_example
# ctrl+\
# kill -3 6073
killall -3 signal_example

# send SIGTERM to signal_example
# kill -15 6073
# kill 6073
# killall -15 signal_example
# or close parent process of programm
killall signal_example

# send SIGKILL to siganl_example
# kill -9 6073
killall -9 signal_example

# run signal_example with abort parameter
./signal_example --abort
# this aborts the programm, since it has registered 
# a special SIGABRT handler: void sig_interrupt_abort(int signal)

# run signal_example with alarm 10 parameters
./signal_example --alarm 10
# SIGALRM handler: void sig_interrupt_alarm(int signal)
# Alarm triggered after 10 seconds.