#!/bin/bash

#####################################################
# 6.2 script which removes file* in while loop      #
#####################################################

i=1
while [ $i -le 100 ]
    do
        rm file$i
        i=$(expr $i + 1)
        # or let i+=1
    done