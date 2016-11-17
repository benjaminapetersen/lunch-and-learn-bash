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


# strangely, giving break `2` in this next example
# tells it to break out of the outer loop as well
# (which will naturally break out of the inner)

for FOO in 1 2 3
do
	for BAR in 0 5
	do
		if [ $FOO -eq 2 -a $BAR -eq 0 ] 
		then
			break 2	
		else
			echo "$FOO and $BAR"
		fi
	done
done
