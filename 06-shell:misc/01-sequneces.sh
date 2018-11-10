#!/bin/bash

#####################################################
# 6.1 sequneces                                     #
#####################################################
# prints out 1 to 10
# seq 1 10

for i in $(seq 1 100)
    do
        echo "$i" > file_$i
    done

# seq <start> <increment> <end>
for i in $(seq 100 -1 1)
    do
        # cp "file_$i" file_0
        cat "file_$i" >> file_0
    done