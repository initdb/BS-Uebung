#!/bin/bash

#####################################################
# 5.1                                               #
#####################################################

# print all env. variables
printenv
VAR="example!"

# still not visable since not exported!
# export VAR="example!"
printenv | grep "VAR"

# print only VAR variable
echo "$VAR"

# print only PATH variable
echo "$PATH"

# watch out here ! can only be done once
PATH="$PATH:$(pwd)"
# PATH="$PATH:."
# show result
echo "$PATH"