#!/bin/bash

# lists each file in directory as:
# item: filename.txt
for i in $( ls ); do
	echo item: $i
done
