#/bin/bash

printenv
VAR="example!"

# still not visable since not exported!
# export VAR="example!"
printenv | grep "VAR"

echo "$VAR"

echo "$PATH"

# watch out here ! can only be done once
PATH="$PATH:$(pwd)"
echo "$PATH"