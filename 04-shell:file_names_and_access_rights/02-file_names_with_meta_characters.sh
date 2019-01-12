#!/bin/bash

# list all files inside the home directory
# that begin with .
ls -d $HOME/.* > 2a

# that contain . but not in the beginning
ls -d $HOME/?*.* > 2b

# create a file with the name "d?"
touch d\?

# create a file with the name "d*""
touch d\*

# rm file d?
test -f d\? && rm d\? 

# create hard and softlink of d*
ln d\* dsternhard
ln d\* -s dsternsoft

rm dstern*

# what directory is shown by "ls -l ~",
# home owned by me

# why has the folder Desktop more than one link ?
# directory has alsways atleast 2 hardlinks name/ + ./ + ../

# clean workdir 
rm ??