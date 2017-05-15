#!/bin/bash

# https://www.tutorialspoint.com/unix/unix-basic-operators.htm
# There are quite a few operators on this page, only going over a couple here

# Bourne shell did not have mechanism for arithmetic,
# so would call out to external programs like
# `awk` or `expr`
# spacing is again fussy, `2+2` will not work.
VAL=`expr 2 + 2`
echo "Total val: $VAL"

# but Bourne now supports these

A=10
B=20
# `expr` will be used to evaluate :/
echo "Addition: `expr $A + $B`"
# echo `expr $A + $B`
# must have the extra spacing
echo "Subtraction: `expr $A - $B`"

echo "Multiplication: `expr $A /* $B`"

echo "Division: `expr $A / $B`"

echo "Modulus: `expr $A % $B`"
# spacing is important around [ ]
echo "Equality: `[ $A == $B ]`"
# spacing!
echo "Not Equal: `[ $A != $B ]`"

# in case I didn't say it enough, spacing :/
