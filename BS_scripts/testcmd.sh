#!/bin/bash -x

test 5 -eq; echo $?
test -z ""; echo $?
VAR=root; test $VAR = root; echo $?
VAR=root; test VAR = root; echo $?

###################################################

touch file
# and / or 
test -r file -a -w file; echo $?
test -r file -o -x file; echo $?
# Klammern
test \( -r file -o -x file \) -a -w file; echo $?