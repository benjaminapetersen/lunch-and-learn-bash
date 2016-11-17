#!/bin/bash

A=0

while [ $A -lt 10 ] 
do

	echo $A
	if [ $A -eq 5 ]
	then
		break
	fi
	A=`expr $A + 1`
done
