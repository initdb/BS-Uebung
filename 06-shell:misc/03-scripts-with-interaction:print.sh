#!/bin/bash

#####################################################
# 6.3 print names of home dir of all users          #
#####################################################
# cut: prints selected parts of lines
# from each file to stdout
# -d delimiter
# -f select only these fields
cut -d : -f 6 /etc/passwd | grep "/home"
