#!/bin/bash

#####################################################
# 6.8a how many "fuck"s are used in the linux kernel#
# source ?                                          #
#####################################################

grep -r "fuck" . | wc -l

# "-i" : ignores case
grep -r -i "fuck" . | wc -l

# also find fuck, pissed, bloddy, bastard within one pattern
# egrep or grep -E needed
egrep -r -i "(fuck|pissed|bloody|bastard)" . | wc -l

# in which files ?
egrep -r -i "(fuck|pissed|bloody|bastard)" . | cut -d : -f 1 | sort -u -r

# replace bloody with damned
grep -r -i -o "bloody" . | cut -d : -f 1 | xargs sed -i 's/bloody/damned/g'