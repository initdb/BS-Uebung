#!/bin/bash

# create file with content
echo "hello there !" > file_r

# change to u+r
chmod 400 file_r

# read file_r
cat file_r

# permission denied
cat "New Text" > file_r

# create dir sub and move file_r into it
mkdir sub
mv file_r sub
chmod 000 sub

# delete file
sudo rm -rf sub