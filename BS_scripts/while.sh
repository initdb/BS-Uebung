#!/bin/bash

# endless loop
while true
do
    echo "ping"
    sleep 1
done

# reads from stdin, into name
read name; echo "helo $name"

# read file: line by line
while read line
do
    echo "$line"
done < file