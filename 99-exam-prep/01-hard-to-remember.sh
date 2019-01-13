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
# seq <start> <increment> <end>
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

i=1
while [ $i -le 100 ]
do
    rm file$i
    i=$(expr $i + 1)
    # or let i+=1
done

#####################################################
# shell: search                                     #
#####################################################
# -i : ignore case
# -o : returns only the match
grep "pattern" file
# ^root     | beginning of the line
# root$     | end of the line
# ^root$    | complete line
# ro.t      | any single character
# ro*t      | preceding character match zero or more times
# root.*t   | any character zero or more times
# r[Oo]ot   | one character from the list of characters
# [^f]oot   | no character from the list of characters

#####################################################
egrep "pattern" file
# ro+t      | preceding character will be matched one or more times
# roo?t     | preceding character will be matched zero or more times
# ro{2}t    | exactly match n times
# root|dev  | alternative matches

#####################################################
find /var -type f       # find all files
find /var -type d       # find all directories

find . -name "*.txt"    # find all files which name contains pattern
find . -iname "*.txt"   # ignore case

find . -name "*txt" -exec rm {} \; # execute a command

# status change with ctime, modification with mtime
find $HOME -type f -ctime -5

#####################################################
# string manipulation
file="file.category.txt"
echo "shortest match from the front: ${file#*.}"
# category.txt
echo "shortest match from the back: ${file%*.}"
# file.category
echo "longest match from the front: ${file##*.}"
# txt
echo "longest match from the back: ${file%%.}"
# file

#####################################################
# shell: misc                                       #
#####################################################
# cut: prints selected parts of lines
# from each file to stdout
# -d delimiter
# -f select only these fields
cut -d : -f 6 /etc/passwd | grep "/home"

# command substitution
echo "you are located here: $(pwd)"

# asynchronous commands
sleep 5&        # do nothing 5 sec in the background
echo "do something useful, while sleeping..."
# wait $!         # wait until the process finished

sleep 60&       # 1 min
jobs            # list running background jobs

sleep 600       # 6 min
CTRL+Z          # pauses a runnig forground process
bg %1           # puts the paused process in the background
fg %1           # puts the paused process 1 in the foreground

#####################################################
# build                                             #
#####################################################
gcc -c main.c               # compile without linking
gcc -o hello_world main.o   # link main.o + deps
gcc -o hello_world main.c
./hello_world               # execute
#####################################################
# make
make
make clean

#####################################################
# commands for ELFs
nm hello_world          # list all symbols from the object file
readelf -a hello_world  # display information about an ELF
                        # object file

#####################################################
# build with automake                               #
#####################################################
# init build system
autoreconf -i
# configure the build
./configure
# build
make
# install the programm
sudo make install
# run the programm
simple_prog
# uninstall the programm
sudo make uninstall