#!/bin/bash

#####################################################
# 6.7b print all unique file extensions into one    #
# file                                              #
#####################################################

find . -type f -exec "../BS-specification/sheet_06_misc/getext.sh" -f {} \; | sort -u > tmp.txt

#####################################################
# 6.7c print number of c files in the linux kernel  #
#####################################################

find . -type f -name "*.c" | wc -l

#####################################################
# 6.7d print number of lines in all c files in the  #
# linux kernel                                      #
#####################################################

find . -type f -name "*.c" -exec cat {} \; > count.txt; wc -l count.txt

#####################################################
# 6.7e rename all c files to cpp file in the        #
# linux kernel                                      #
#####################################################

find . -type f -name "*.c" -exec mv {} {}pp \;