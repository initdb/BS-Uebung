#!/bin/bash

# if not readable, it can't be executed
test -r exer5.sh && cat exer5.sh

if [ -r exer5.sh ]; then
    cat exer5.sh
fi