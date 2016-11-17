#!/bin/bash

VAR1="foo"
VAR2="baz"

if [ $VAR1 = 'foo' ]; then
	echo "Yup, its foo: $VAR1"
fi


if [ "$VAR1" = "$VAR2" ]; then
	echo "They are equivalent, $VAR1 is the same as $VAR2"
else
 echo "Nope, $VAR1 is not the same as $VAR2"
fi



