#!/bin/bash

COUNTER=20
# until executes until the control expression evalues to false
until [ $COUNTER -lt 10 ]; do
	echo COUNTER $COUNTER
	let COUNTER-=1
done
