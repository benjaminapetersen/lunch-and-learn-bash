#!/bin/bash

echo "File name: $0"
echo "First param: $1"
echo "Second param: $2"
echo "Quoted values: $@"
echo "Quoted values: $*"
echo "Total number of params: $#"

# loop and print each token:
for TOKEN in $*
do 
	echo "- arg: $TOKEN"
done

echo "Exit $?"
