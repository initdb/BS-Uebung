#/bin/bash

# create and fill files
for i in $(seq 1 1 9)
do
    echo "$i" > "file_$i"
done

# saves the content of file_* to file_0
cat file_* > file_0

# ... in file_* | file_[1-9]
for i in $(seq 1 1 9)
do
    cat "file_$i" >> file_00
done

#rm file_*