#!/bin/bash

#####################################################
# 7.1 build and run on commandline                  #
#####################################################

gcc main.c -o main && ./main

#####################################################
# 7.2 explore ELF file                              #
#####################################################
# list all printable files in a binary file
strings main > strings_main.txt

# list all symbols from the object file
nm main > nm_main.txt

# get size of the programm
ls -l | grep main

# delete the symbol table information
strip main
# nm now schows "nm: main: no symbols"


