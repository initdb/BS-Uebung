#!/bin/bash

#####################################################
# 7.4 build with automake                           #
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