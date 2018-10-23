#!/bin/bash

#####################################################
# 3.1                                               #
#####################################################
# list all user cmds and write them to file
ls /usr/bin >> cmdlist
ls /bin >> cmdlist
wc -l cmdlist
# list all system cmds and write them to file
ls /sbin >> syscmdlist
ls /usr/sbin >> syscmdlist
wc -l syscmdlist
# write both to summary file
cat cmdlist >> allcmdlist
cat syscmdlist >> allcmdlist
# count the cmds
wc -l allcmdlist
# sort them in alphabetical order
sort allcmdlist > /dev/null

#####################################################
# 3.2                                               #
#####################################################
# create header file and 
# write content of allcmdlist to it
echo "All commands: $(cat allcmdlist)" > header
# create tail file and write cmd count to it
echo "A total of count $(wc -l allcmdlist) commands" > trailer
# write header and tail into summary
cat header >> summary
cat trailer >> summary
# print first 10 lines of summary
head summary
# print first 12 lines
head -n 12 summary
# print last 10 lines of summary
tail summary
# print last 12 lines
tail -n 12 summary
# print lines 100 - 150 site by site
head -n 150 summary | tail -n 50 | less
# reverse print cat -> tac summary
tac summary | less
#wc -c header # print byte count
#wc -w header # print word count
#wc -l header # print line count
# prints line, word, byte count of header
wc header
# rename header to HEADER
mv header HEADER
# create testdir
mkdir testdir
# move summary to testdir
mv summary testdir
# copy file
cp testdir/summary .
# create hardlink
ln testdir/summary summary2
# create symbolic link
ln -s testdir/summary summary.s

#####################################################
# clean up workdir                                  #
#####################################################
# remove everything but ueb3.sh script
rm -r !(ueb3.sh)