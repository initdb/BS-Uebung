#!/bin/bash

#####################################################
# 8.3 use and inspect your own package with dpkg    #
#####################################################
cd hello
package="hello_2.10-1-0ubuntu1_amd64.deb"

# list information about newly created package
dpkg --info $package

# list all files inside package
dpkg --contents $package

# install package from file
sudo dpkg -i $package

# check if the package is installed
dpkg -l | grep hello
# alternative?: whereis hello

# run hello
hello

# search for all files named hello in all installed packages
dpkg -L hello

# remove the package
sudo dpkg -r hello