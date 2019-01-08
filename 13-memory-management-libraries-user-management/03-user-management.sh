#!/bin/bash

#####################################################
# 13.3 user management                              #
#####################################################
# which users exist on your system ?
cat /etc/passwd
sudo cat /etc/shadow
# which groups exist on your system ?
cat /etc/group
# create a new user test
sudo adduser test
# in which group is your new user ?
groups test
# create a new group dev_data
sudo addgroup dev_data
# add user test to group dev_data
usermod -g dev_data test
groups test

cat /etc/passwd | grep test
cat /etc/group | grep test
cat /etc/group | grep dev_data