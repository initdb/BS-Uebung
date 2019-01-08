#!/bin/bash

#####################################################
# 2.4 explore / filesystem                          #
#####################################################
# change to /
cd /

# list all files and folders
ls -la

#####################################################
# what is the meaning of these files and folders ?  #
#####################################################

# extracted from "How Linux Works: What Every Superuser should know", Brain Ward 2014 p.113f
#===================================================#
# /bin                                              #
#===================================================#
# Contains ready-to-run programs (also known as an executables), 
# including most of the basic Unix commands such as ls and cp. 
# Most of the programs in /bin are in binary format, 
# having been created by a C compiler, but some are shell scripts in modern systems.
#===================================================#
# /dev                                              #
#===================================================#
# Contains device files. You’ll learn more about these in Chapter 3.
#===================================================#
# /etc                                              #
#===================================================#
# This core system configuration directory (pronounced EHT-see) 
# contains the user password, boot, device, networking, 
# and other setup files. 
# Many items in /etc are specific to the machine’s hardware.
# For example, the /etc/X11 directory contains graphics card 
# and window system configurations.
#===================================================#
# /home                                             #
#===================================================#
# Holds personal directories for regular users. 
# Most Unix installations conform to this standard.
#===================================================#
# /lib                                              #
#===================================================#
# An abbreviation for library, this directory holds 
# library files containing code that executables can use. 
# There are two types of libraries: static and shared. 
# The /lib directory should contain only shared libraries, 
# but other lib directories, such as /usr/lib, 
# contain both varieties as well as other auxiliary files. 
# (We’ll discuss shared libraries in more detail in Chapter 15.)
#===================================================#
# /proc                                             #
#===================================================#
# Provides system statistics through a browsable 
# directory-and-file interface. 
# Much of the /proc subdirectory structure on Linux is unique,
# but many other Unix variants have similar features. 
# The /proc directory contains information about currently 
# running processes as well as some kernel parameters.
#===================================================#
# /sys                                              #
#===================================================#
# This directory is similar to /proc in that it provides
# a device and system interface. You’ll read more about /sys in Chapter 3.
#===================================================#
# /sbin                                             #
#===================================================#
# The place for system executables. 
# Programs in /sbin directories relate to system management, 
# so regular users usually do not have /sbin components in 
# their command paths. Many of the utilities found here 
# will not work if you’re not running them as root.
#===================================================#
# /tmp                                              #
#===================================================#
# A storage area for smaller, temporary files that you don’t care much about.
# Any user may read to and write from /tmp, 
# but the user may not have permission to access another user’s files there. 
# Many programs use this directory as a workspace. 
# If something is extremely important, 
# don’t put it in /tmp because most distributions clear /tmp when the machine boots
# and some even remove its old files periodically.
# Also, don’t let /tmp fill up with garbage because its space is usually shared 
# with something critical (like the rest of /, for example).
#===================================================#
# /usr                                              #
#===================================================#
# Although pronounced “user,” this subdirectory has no user files.
# Instead, it contains a large directory hierarchy, 
# including the bulk of the Linux system. 
# Many of the directory names in /usr are the same as those 
# in the root directory (like /usr/bin and /usr/lib), 
# and they hold the same type of files. 
# (The reason that the root directory does not contain the 
# complete system is primarily historic — in the past, 
# it was to keep space requirements low for the root.)
#===================================================#
# /var                                              #
#===================================================#
# The variable subdirectory, where programs record runtime information.
# System logging, user tracking, caches, and other files that system programs
# create and manage are here. (You’ll notice a /var/tmp directory here,
# but the system doesn’t wipe it on boot.)
#===================================================#
# /boot                                             #
#===================================================#
# Contains kernel boot loader files. 
# These files pertain only to the very first stage of the Linux startup procedure; 
# you won’t find information about how Linux starts up its services in this directory.
# See Chapter 5 for more about this.
#===================================================#
# /media                                            #
#===================================================#
# A base attachment point for removable media such as flash drives that is 
# found in many distributions.
#===================================================#
# /opt                                              #
#===================================================#
# This may contain additional third-party software. 
# Many systems don’t use /opt.

#===================================================#
# The /usr Directory                                #
#===================================================#
# The /usr directory may look relatively clean at first glance,
# but a quick look at /usr/bin and /usr/lib reveals that there’s a lot here; 
# /usr is where most of the user-space programs and data reside. 
# In addition to /usr/bin, /usr/sbin, and /usr/lib, /usr contains the following:
# /include Holds header files used by the C compiler.
# /info Contains GNU info manuals (see 2.13 Getting Online Help).
# /local Is where administrators can install their own software. 
# Its structure should look like that of / and /usr.
# /man Contains manual pages.
# /share Contains files that should work on other kinds of Unix machines with no loss of functionality. In the past,
# networks of machines would share this directory, 
# but a true /share directory is becoming rare because there are 
# no space issues on modern disks. Maintaining a /share directory is often just a pain.
# In any case, /man, /info, and some other subdirectories are often found here.
