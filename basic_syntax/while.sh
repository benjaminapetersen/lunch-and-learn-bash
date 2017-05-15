#!/bin/bash


# print incrementing numbers from 1 to 10 on new lines, 
# while printing decrementing numbers from the incremented
# example:
# 1
# 12
# 123
# 1234
# 12345
# etc
A=0
while [ $A -lt 10 ]
do
	B=$A
	while [ $B -gt 0 ]
	do
		echo -n $B
		B=`expr $B - 1`
	done
	echo
	A=`expr $A + 1`
done
