#!/bin/bash

#####################################################
# 6.6 extract the (last) extension of a file name   #
#####################################################

file=$0

# prints file extension
echo "${file##*.}"