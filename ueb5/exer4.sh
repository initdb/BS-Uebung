#!/bin/bash

#if [ $# -eq 1 ]; then
#    echo "correct call"
#else
#    echo "wrong number of parameters"
#    exit 1
#fi

if [ $# -eq 1 ] && [ $1 = ~ ]; then
    echo "Yes, this is your home directory."
else
    echo "No, this isn't your home directory."
    exit 1
fi