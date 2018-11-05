#!/bin/bash

#####################################################
# 5.4                                               #
#####################################################
# check if on argument is supplied
#if [ $# -eq 1 ]; then
#    echo "correct call"
#else
#    echo "wrong number of parameters"
#    exit 1
#fi

# test: -a and -o or, but better to read is [] && [].
# both ~ and $HOME possible
if [ $# -eq 1 ] && [ $1 = ~ ]; then
    echo "Yes, this is your home directory."
else
    echo "No, this isn't your home directory."
    exit 1
fi