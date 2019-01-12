#!/bin/bash

#####################################################
# access rights                                     #
#####################################################
# rights on directories
# +-------+-------------------------------------------+
# | right | description                               |
# +-------+-------------------------------------------+
#     x   | you can enter (cd) this directory
#     rx  | - " - & read (ls) this directory
#     wx  | - " - & - " - & create, read, (re)move files

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

#####################################################
# shell: script parameter                           #
#####################################################
# $0    |   Name of the script
# $1    |   First parameter of shell script (or function)
# $2    |   Second parameter of shell script (or function)
# ...
# ${10} |   10th parameter of shell script (or function)
# ${11} |   11th parameter of shell script (or function)
# ...
# $#    |   Number of parameters, starting from one
# $*    |   Expands the parameters as one string, starting from one
# $@    |   Expands each parameter in a separate string, starting from one   
# $?    |   Exit status of the last command/process
# $$    |   Process id of shell
# $!    |   Process id of last command/process started asynchronously   

#####################################################
# shell: controll structures                        #
#####################################################

# create and fill files with index i
for i in $(seq 1 1 9)
do
    echo "$i" > "file_$i"
done

# test: -a and -o or, but better to read is [] && [].
# both ~ and $HOME possible
# [[ && || ]] <-- supports normal c syntax! but not available on all systems ?!
if [ $# -eq 1 ] && [ $1 = ~ ]; then
    echo "Yes, this is your home directory."
else
    echo "No, this isn't your home directory."
    exit 1
fi