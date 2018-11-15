#!/bin/bash

#####################################################
# 8.1 software management                           #
#####################################################
# search for a package
# p flag for purged, i for installed
apt search rar

# list packages by name
apt list rar
# Listing... Done
# rar/bionic,now 2:5.5.0-1 amd64 [installed]


# show dependency information of a package
apt depends rar
# rar
#   Depends: libc6
#   Depends: libgcc1
#   Depends: libstdc++6
#   Suggests: unrar

# install a programm
apt install rar

# delete a programm
apt remove rar