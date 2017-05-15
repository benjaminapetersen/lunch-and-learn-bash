#!/bin/bash

OPTION=${1};

case $OPTION in
	-f) FILE=${2}
			echo "File name is $FILE"
			;;
	-d) DIR=${2}
			echo "Dir name is $DIR"
			;;
	*)  
			# `basename` will print the file name
      echo "`basename ${0}`:usage: [-f file] [-d directory]"
			exit 1 # fail
			;;
esac
