#!/bin/bash

cat /etc/passwd | grep "root"

# start of line
cat /etc/passwd | grep "^root"

# start of line and root is end of word
cat /etc/passwd | grep "^root\>"

# " and translate o to a
cat file | grep "^root\>" | tr o a

# " and delete char ":"
cat file | grep "^root\>" | tr -d :

# " and display only these field with delimiter ":"
cat file | grep "^root\>" | cut -d : -f 6

cat file | grep "^root\>" | cut -d : -f 3

# display only the telefone numbers of names.csv
cut -d , -f 2 names.csv