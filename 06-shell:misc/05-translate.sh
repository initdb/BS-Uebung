#!/bin/bash

#####################################################
# 6.5 create a file, convert it contents to upper   #
# case and back to lower case                       #
#####################################################

echo "This is an example!" > text

# translate: lower to upper case.
cat text | tr a-z A-Z > text.uppercase

# translate: upper to lower case.
cat text.uppercase | tr A-Z a-z > text.lowercase