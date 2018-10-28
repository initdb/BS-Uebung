#!/bin/bash
# List all the commands in /bin and /usr/bin

# begin with a x
ls /bin/x* /usr/bin/x* > 1a

# end with a d
ls /bin/*d /usr/bin/*d > 1b


# begin with a c end with a d
ls /bin/*d /usr/bin/x*d > 1c

# contain at least one digit
ls /bin/?* /usr/bin/?* > 1d

# contains an e which is neither
# in the beginning nor at the end
WORD=[!e]*e*[!e]
ls /bin/$WORD /usr/bin/$WORD > 1e

# begin with y or z
WORD=[yz]*
ls /bin/$WORD /usr/bin/$WORD > 1f

# doesn't begin with x,y or z
WORD=[!x-z]*
ls /bin/$WORD /usr/bin/$WORD > 1g

# consist of 1 character
WORD=?
ls /bin/$WORD /usr/bin/$WORD > 1h

# consist of 2 characters
WORD=??
ls /bin/$WORD /usr/bin/$WORD > 1i

# consist of 2 or 3 character
#ls /bin/?? /usr/bin/?? > j1 && ls /bin/??? /usr/bin/??? > j2

# clean workdir 
rm ??