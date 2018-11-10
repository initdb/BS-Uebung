#!/bin/bash

for i in 1 2 3 4
do
    echo "$i"
done

array=(1 2 3 4)
for i in ${array[@]}
do
    echo "$i"
done

for filename in *.sh; do
    echo "$filename found"
done