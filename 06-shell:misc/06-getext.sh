#!/usr/bin/env bash

print_usage ()
{
    echo "Usage $0 [-f <filename>]"
    echo "If -f is not specified, $0 reads from stdin."
}

filename=""
mode=stdin
while getopts f: opt; do
    case $opt in
    f )
        filename="$OPTARG"
        mode=file
        ;;
    esac
done
shift "$((OPTIND-1))" # Discard the options and sentinel --

extract_and_print_ext ()
{
    filename="$1"
    filename="${filename##*/}"  #extract filename with ext

    if [ -z ${filename##*.*} ]; then
        ext=".${filename##*.}"
    else
        ext=""
    fi

    echo "$ext"
}

if [ $mode = stdin ]; then
    while read filename
    do
        extract_and_print_ext "$filename"
    done
else
    extract_and_print_ext "$filename"
fi