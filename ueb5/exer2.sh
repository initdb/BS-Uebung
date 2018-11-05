#!/bin/bash

# print number of arguments, starting from one
# NPARAM="$#"
# echo "number of parameters: $NPARAM"
echo "number of parameters: $#"

# seq start interval end
# expr calculation in shell script
for i in "$@" # "" wichtig sonst werden 3 Zeilen ausgegeben
do
    echo " parameter: $i"
done
#for i in $(seq 0 1 $(expr $NPARAM - 1))
#do
#    echo -n " parameter $i: $1"
#    shift
#done
#echo -ne "\n"

# unset NPARAM