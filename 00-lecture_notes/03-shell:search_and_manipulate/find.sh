#!/bin/bash

#########################################################################
# https://www.tecmint.com/35-practical-examples-of-linux-find-command/  #                                              #
#########################################################################

#########################################################################
# find flags read/write/execute                                         #
#########################################################################
# -type f for file
find . -type f -perm /u=r+w+x
find . -readalbe -writable -executable

#########################################################################
# time stamps                                                           #
#########################################################################
find . -amin        # access time
find . -atime
find . -cmin -60    # file status change time, which were modified in the last 60 mins
find . -ctime
find . -mmin        # modification time
find . -mtime 2     # files that were changed exactly 2 days ago

#########################################################################
# file size                                                             #
#########################################################################
find . -size 50k    # exactly 50k
find . -size -50k   # all smaller 50k
find . -size +50k   # all greater 50k

#########################################################################
# user/group                                                            #
#########################################################################
find . -group dev
find . -user root

#########################################################################
# expressions: and, or, not ?                                           #
#########################################################################
# and applied by default, so not needed
find . -readable -and -name "file_*"
find . -readable -a -name "file_*"

find . -readable -or -name "file_*"
find . -readable -o -name "file_*"

find . ! -readable
find . -not -readable