#!/bin/bash

#####################################################
# 6.8a how many "fuck"s are used in the linux kernel#
# source ?                                          #
#####################################################
grep -r "fuck" . | wc -l

# "-i" : ignores case
grep -r -i "fuck" . | wc -l

#####################################################
# 6.8d also find fuck, pissed, bloddy, bastard      #
# within one pattern egrep or grep -E needed since  #
# using regex.                                      #
#####################################################
egrep -r -i "(fuck|pissed|bloody|bastard)" . | wc -l

#####################################################
# 6.8f in which files are these hits(reverse order, # 
# only uniques).                                    #
#####################################################
egrep -r -i "(fuck|pissed|bloody|bastard)" . | cut -d : -f 1 | sort -u -r

#####################################################
# 6.8g replace bloody with damned in all files that #
# contain bloody. cut -d : -f 1 only works with -f  #
# xargs executes sed for each found file, wouldn't  #
# work otherwise!!                                  #
#####################################################
grep -r -i -o "bloody" . | cut -d : -f 1 | xargs sed -i 's/bloody/damned/g'