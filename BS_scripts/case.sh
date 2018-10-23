#!/bin/bash

var="1"
case "$var" in
    1)          echo "1 chosen"
                echo "..."
                ;;
    h)          echo "h chosen"     ;;
    "hello")    echo "hello chosen" ;;
    *)          echo "$var chosen"  ;;
esac