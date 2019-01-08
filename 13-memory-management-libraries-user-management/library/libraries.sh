#!/bin/bash

#####################################################
# 13.2 libraries                                    #
#####################################################
# compile supermath as shared lib
gcc -fPIC -shared -o libsupermath.so supermath.c

# copy header to /usr/local/include
#sudo cp supermath.h /usr/local/include

# copy lib to /usr/lib
#sudo cp libsupermath.so /usr/lib
cd ../main_programm
gcc -o math math.c -lsupermath
math 1 + 2
cd ../library