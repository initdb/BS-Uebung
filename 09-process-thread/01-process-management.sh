#!/bin/bash

#####################################################
# 9.1 process management                            #
#####################################################
# list all running processes
# a & x (aux) list all running processes
# x list all processes owned by you
ps aux

# USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# root         1  0.4  0.2 159992  9132 ?        Ss   19:33   0:04 /sbin/init splash
# root         2  0.0  0.0      0     0 ?        S    19:33   0:00 [kthreadd]

#####################################################
# how many processes are running ?
ps aux | wc -l

#####################################################
# which processes are created first ?
# the ones with a lower pid

#####################################################
# why are gaps between the pid ?
# the gaps are from processes which have already concluded.

#####################################################
# what is the lowest pid and what is the meaning
# of this process ?
# pid 1 -> systemd

#####################################################
# displays all process & -p with pid
pstree -p

#####################################################
# show grand parent process of pstree
# -> mate session
pstree | grep pstree -B 5