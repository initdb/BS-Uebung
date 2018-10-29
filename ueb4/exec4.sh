#!/bin/bash

# create a directory datacontainer
mkdir datacontainer

# create new group with sudo addgroup data
# sudo addgroup data

# create a directory named config in datacontainer
mkdir datacontainer/config

# create two files
touch datacontainer/config/cfg1 datacontainer/config/cfg2

# which group and rights does the newly
# created directories and files have?
# dev dev, 764

# change group to data on datacontainer
sudo chgrp data datacontainer

# change ownership with chown
# set the setgid right on datacontainer
sudo chmod g+s datacontainer # ask prof

# create dir config2 in datacontainer
mkdir datacontainer/config2

touch datacontainer/config2/cfg1 datacontainer/config2/cfg2

# show it worked
ls -l datacontainer

# clean up 
rm -rf datacontainer