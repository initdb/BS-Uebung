#!/bin/bash

#####################################################
# 5.2                                               #
#####################################################

# print number of arguments, starting from one
echo "number of parameters: $#"

for i in "$@" # "" wichtig sonst werden "" nicht beachtet und mehr Zeilen ausgegeben
do
    echo " parameter: $i"
done

#####################################################
# to complicated alternative:                       #
#####################################################
# seq start interval end
# expr calculation in shell script
#for i in $(seq 0 1 $(expr $# - 1))
#do
#    echo -n " parameter $i: $1"
#    shift
#done
