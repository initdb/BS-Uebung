#!/bin/bash

#####################################################
# symbolic & hard links                             #
#####################################################
# create hardlink
ln testdir/summary summary2
# create symbolic link
# $ ln -s target linkname
ln -s testdir/summary summary.s

#####################################################
# shell variables                                   #
#####################################################
var1=1          # numerical value
var2=abc        # string
var3=true       # string
array1=(1 2 3)  # array
array2[0]="string with spaces"
array2[1]=b

echo "var1: $var1"
echo "var2: $var2"
echo "array1 has ${#array1[*]} elements"
echo "array2[1]: ${array2[1]}"
echo "all array 2 elements: ${array2[@]}"

unset var3      # delete variable

#####################################################
# test / [ cmd                                      #
#####################################################
test -e file    # file exists
test -d dir     # directory exists
test -f file    # regular file

test -r file    # readable
test -w file    # writeable
test -x script.sh && ./script # executable

# compare numerical
test 5 -eq 5
test 5 -ne 4

# compare strings
test "string" = "string"
test "string" != "string"

# link multiple test commands
test -r file -a -w file
test -r file -o -w file