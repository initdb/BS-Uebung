#!/bin/bash

#####################################################
# 14.1 using drivers                                #
#####################################################
# check if scull driver is already loaded
lsmod | grep scull
cat /proc/devices | grep scull

# open an additional terminal and open the kernel log
tail -f /var/log/kern.log

# load the module scull.ko into the system
sudo insmod scull.ko
# -> mayor device number 244

# create the two device files
sudo mknod /dev/scull0 c 244 0
sudo mknod /dev/scull1 c 244 1

# change the owner of both device files to dev
sudo chown dev scull0 scull1

# compile mycat.c
gcc -o mycat mycat.c

# write a string to scull0, use mycat to copy the string
# from scull0 to scull1. Then read the content 
echo "Hello there" > /dev/scull0
./mycat /dev/scull0 > /dev/scull1
cat /dev/scull1

# unload the driver module
rmmod scull

# remove both device files
rm /dev/scull*