#!/bin/bash
if test -f file
then
    echo "file is regular file"
else
    echo "file isn't regular file"
fi

# short variant
# watch out for spaces!! [ <--> ]
if [ -f file ]; then
    echo "file is regular file"
else
    echo "file isn't regular file"
fi

# shortest
if [ -f test ]; then echo "file is a regular file"; fi
[ -f test] && echo "file is a regular file"