#!/bin/bash

#####################################################
# 2.3 explore /home/dev                             #
#####################################################
# create directory
mkdir project

# create several directories in with one command
mkdir project/doc project/src project/src/package1 project/src/package2

# create hidden directory
mkdir project/.config

ls -R project
# change into project/src/package1
cd project/src/package1 && pwd

# change into the last folder
cd -

# change into project/src/package2
cd project/src/package2

# change into project/src without explictly using the name
cd ..
cd ..

# remove the created directories with rmdir
rmdir project/src/package1 project/src/package2 project/src project/doc project/.config project

# change into home director without explicitly using /home/dev
cd
cd ~
cd $HOME