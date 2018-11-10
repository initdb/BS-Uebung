#!/bin/bash

#####################################################
# 6.2 script which renames file_* to file*          #
#####################################################

for i in $(seq 1 100)
    do
        mv file_$i file$i
    done