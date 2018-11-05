#!/bin/bash

#########################################################################
# https://www.tecmint.com/35-practical-examples-of-linux-find-command/  #                                              #
#########################################################################

# find flags read/write/execute
find . -type f -perm /u=r+w+x
