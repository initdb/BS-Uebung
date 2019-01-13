#!/bin/bash

#####################################################
# process information                               #
#####################################################
# find the process PID of demo_programm
# second column
./demo_program &
ps aux | grep demo_program

# how much CPU percentage and memory does the process use ?
# %CPU 3rd column, %MEM 4th column

# stop the programm
# if the programm is running in the fg -> ctrl + c
# if in bg killall or kill with PID
killall demo_program