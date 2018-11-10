#!/bin/bash

#####################################################
# 6.2 script which removes file* in while loop      #
#####################################################

i=0
while [ $i -lt 100 ]
    do
        i=$(expr $i + 1)
        # or let i+=1
        rm file$i
    done