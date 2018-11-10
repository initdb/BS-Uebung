#!/bin/bash

#####################################################
# 5.5                                               #
#####################################################

# if not readable, it can't be executed
# else executes script
test -r exer5.sh && cat exer5.sh

# alternative:
if [ -r exer5.sh ]; then
    cat exer5.sh
fi