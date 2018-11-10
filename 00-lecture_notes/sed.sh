#!/bin/bash

sed -n '4p' file    # print first line of file
sed -n '4,8p' file  # print 4-8th line of file
sed -n "4,\$p" file  # print 4th-EOF of file
                     # to escape use ""

# rename first occurence of "dev", "g" for all
cat file | grep "^dev\>" | sed 's/dev/simon/g'

# sed -i for insert into file
cat file | grep "^dev\>" | sed -i 's/dev/simon/g'

# delete lines from file which contain root
sed '/root/d' file