#!/bin/bash

print_usage () {
    echo "$0 prints first argument"
}

print_name () {
    echo "first argument is $1"
}

if [ $# -eq 1 ]; then
    print_name $1
    exit 0
else
    print_usage
    exit 1
fi