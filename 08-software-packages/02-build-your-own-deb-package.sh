#!/bin/bash

#####################################################
# 8.2 build your own deb package                    #
#####################################################

test -d hello || mkdir hello

cd hello

# download file
test -f hello-2.10.tar.gz || wget http://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz

# x: extract, z: unzip file
tar xzf hello-2.10.tar.gz

# create debian folder and files
cd hello-2.10
dh_make -f ../hello-2.10.tar.gz -s -y

# delete unnecessary
cd debian && rm *.ex *.EX README* 2> /dev/null

# copy edited files to package
test -f ../../changelog && cp ../../changelog .
test -f ../../control && cp ../../control .
test -f ../../copyright && cp ../../copyright .
test -f ../../format && cp ../../format ../source/

cd ..

# configure the build
./configure

# build
dpkg-buildpackage -us -uc