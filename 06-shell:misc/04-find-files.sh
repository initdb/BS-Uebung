#!/bin/bash

#####################################################
# 6.4 display all regular files inside the home dir #
# recursively which were changed in the last 5 days #
#####################################################

HERE=$HOME

# status change with ctime, modification with mtime
find $HERE -type f -ctime -5