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
# string manipulation                               #
#####################################################
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

#####################################################
# software management                               #
#####################################################
# search for a package
# p flag for purged, i for installed
apt search rar

# list packages by name
apt list rar
# Listing... Done
# rar/bionic,now 2:5.5.0-1 amd64 [installed]

# show dependency information of a package
apt depends rar
# rar
#   Depends: libc6
#   Depends: libgcc1
#   Depends: libstdc++6
#   Suggests: unrar

# install a programm
apt install rar

# delete a programm
apt remove rar

#####################################################
dpkg -i rar     # install package
dpkg -r rar     # remove package

#####################################################
# boot procedure: UEFI                              #
#####################################################
#   +------------------------------+
#   |           Power on           |
#   +------------------------------+
#                   |
#                   v
#   +------------------------------+
#   |             UEFI             |
#   | Unified Extensible Firmware  |
#   | Interface -> executes EFI    |
#   | programm files               |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |              GPD             |
#   | GUID Partition Table         |
#   | -> describes disk partitions |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |       Boot loader: GRUB2     |
#   | Grand Unified Bootloader 2   |
#   | -> executes boot menu/kernel |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |           Boot menu          |
#   | -> choose kernel for boot    |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |          Linux kernel        |
#   | -> executes /bin/systemd     |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |      User space: systemd     |
#   | -> executes runlevel         |
#   | programms                    |
#   +------------------------------+
#                   v
#   +------------------------------+
#   |            Targets           |
#   | Starts Targets /etc/systemd/ |
#   | system/default.target        |
#   +------------------------------+
#                   |
#                   v
#   +------------------------------+
#   |     Linux ready for work     |
#   +------------------------------+

#####################################################
# protection: user space vs. kernel space           #
#####################################################
#   +-----------------------------------------------+
#   |   +---------------------------------------+   |
#   |   |              User space               |   |
#   |   | +-------+    +---------+    +------+  |   |
#   |   | |systemd|    |user code|    | bash |  |   |
#   |   | +-------+    +---------+    +------+  |   |
#   |   +---------------------------------------+   |
#   |   +---------------------------------------+   |
#   |   |         GNU C Libraray (glibc)     ^  |   |
#   |   +------------------------------------|--+   |
#   +----------------------------------------|------+
#                                            |
#   +----------------------------------------|------+
#   |                 Kernel space           |      |
#   |   +------------------------------------|--+   |
#   |   |          System call interface     v  |   |
#   |   +---------------------------------------+   |
#   |   +---------------------------------------+   |
#   |   |          Kernel with services         |   |
#   |   +---------------------------------------+   |
#   |   +---------------------------------------+   |
#   |   |        Device Modules & Drivers    ^  |   |
#   |   +------------------------------------|--+   |
#   +----------------------------------------|------+
#                                            |
#   +----------------------------------------|------+
#   |               Physical Hardware        |      |
#   |   +------------------------------------|--+   |
#   |   |   +-----+  +--------+  +---------+ v  |   |
#   |   |   | CPU |  | Memory |  | Devices |    |   |
#   |   |   +-----+  +--------+  +---------+    |   |
#   |   +---------------------------------------+   |
#   +-----------------------------------------------+
#   User space:
#       * all code outside the kernel
#       * also called "userland
#       * restricted (encapsulated) access to the hardware
#       * can only use a subset of CPU instructions
#       * can only access the assigned memory address
#       * crashes in a user process: only stops
#   Kernel space:
#       * complete and unrestricted access to the hardware
#       * can execute any CPU instruction
#       * can access any memory address
#       * crashes in the kernel are "catastrophic": system stop!

#####################################################
# process management & information                  #
#####################################################
# display all running processes
ps aux
# search for your process
ps aux | grep myprog
# stop the process
# when in foreground
CRTL+C
# when in background 
killall myprog      # or kill pid
# hard kill
killall -9 myprog   # or kill -9 pid
# wait for a process to finish
wait pid

#####################################################
# race condition                                    #
#####################################################
# semaphores
# seminit(s,1);
# P(s); -> -1
# ... critical area ...
# V(s); -> 1

#####################################################
# process communication                             #
#####################################################
# send(destination, message)| send a message to the destination.
# recv(source, &message)    | receive a message from the source.
# blocking/synchron         | send()/recv() blocks until the
#                           | data is fully transfered.
# non-blocking/asynchron    | send()/recv() immediatly returns
#                           | and the process can proceed.
# protocol required         | a protocol defines the order of
#                           | the send()/recv() between pro-
#                           | cesses and the message format.
# half-duplex/unidirectional| communication over a "channel"
#                           | only in one direction.
# full-duplex/bidirectional | communication over a "channel"
#                           | in both directions.

#####################################################
# socket: connection oriented (TCP)                 #
#####################################################
# void server() {                                | void client() {
#   socket(...); //create comm. interface        |
#   bind(...);   //connect address with socket   |
#   listen(...); //create a queue                |
#   accept(...); //wait until client connects    |
#                                                |   socket(...); //create comm. interface
#                                                |   connect(...); //connect to server
#   //unblock the server                         |
#                                                |   //send data
#                                                |   send(...)/write(...);
#   //receive data                               |
#   //recv(...)/read(...)                        |
#   //...                                        |   //...
#                                                |
#                                                |   //close socket and connection
#                                                |   close(...);
#   //close socket and connection                |
#   close(...);                                  |
# }                                              | }
#####################################################
# socket: connectionless (UDP)                      #
#####################################################
# void server() {                                | void process2() {
#   socket(...);    //create comm. interface     |
#   bind(...);      //connect address with socket|
#   recvfrom(...);  //receive from socket        |
#                                                |   socket(...); //create comm. interface
#                                                |   sendto(...); //send data
#   //...                                        |   //...
#                                                |   recvfrom(...) //receive from socket
#   sento(...);     //send data                  |   //...
#   //...                                        |
#                                                |   //close socket and connection
#   //close socket and connection                |   close(...);
#   close(...);                                  |
# }                                              | }

#####################################################
# process communication summary                     #
#####################################################
# mechanism     |data|store|acess contr.|remote|bidirect.|fast|prio.|sync req.
# --------------+----+-----+------------+------+---------+----+-----+---------
# signal        |    |     |            |      |         | X  |     |
# unix socket   | X  |     |     X      |      |    X    | X  |     |
# network socket| X  |     |            |   X  |    X    |    |     |
# pipe          | X  | _x_ |     X      |      |         | X  |     |
# message queue | X  |  X  |     X      |      |         | X  |  X  |
# shared memory | XX |  X  |     X      |      |    X    | XX |     |   X

#####################################################
# deadlocks                                         #
#####################################################
# safe state:
#   * a state is save, if there is no deadlock,
#     and there exists at least.
#   * one sequence of processes that ends not in a deadlock.
# unsafe state:
#   * a state is unsafe if there is a deadlock, or there
#     exists only sequences that end in a deadlock.
#   * it is not guaranteed that all processes can finish.
#   * a deadlock is an unsafe state

#####################################################
# memory management                                 #
#####################################################
# caching :
# data buffers on various locations, for example
# CPU cache, memory cache and disk cache
#
# hit: 
# a hit occours on repeated access of the same
# memory address
# fault:
# occours on the first access. the cache is to small
# to buffer all data.

#####################################################
# shared libraries                                  #
#####################################################
# compile supermath as shared lib
gcc -fPIC -shared -o libsupermath.so supermath.c

# link against a lib existing in /usr/lib or /lib
# note: the lib is excluded in the -l command!!
gcc -o math math.c -lsupermath

#####################################################
# device files                                      #
#####################################################
# create a device file
mknod /dev/device_file TYPE MAJOR MINOR
# TYPE = c or b
# MAJOR = device type and corresponding driver
# MINOR = device within the driver

# delete a device fie
rm /dev/device_file

#####################################################
# kernel module commands                            #
#####################################################
# list the loaded modules /proc/modules
lsmod
# load the module in to the kernel
insmod module.ko
modprobe module
# unload the module
rmmod module
modprobe -r module