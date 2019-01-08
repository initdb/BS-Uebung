#!/bin/bash

#####################################################
# symbolic & hard links                             #
#####################################################
# create hardlink
ln testdir/summary summary2
# create symbolic link
# $ ln -s target linkname
ln -s testdir/summary summary.s