#!/bin/bash

#####################################################
# 5.3                                               #
#####################################################

# create and fill files with index i
for i in $(seq 1 1 9)
do
    echo "$i" > "file_$i"
done

# saves the content of file_* to file_0
cat file_* > file_0

# for i in file_* oder for i in file_[1-9]
# so wird über files iteriert
for i in $(seq 1 1 9)
do
    cat "file_$i" >> file_00
done

# clean work dir
# rm file_*