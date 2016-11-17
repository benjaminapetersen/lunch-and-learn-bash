#!/bin/bash

# https://www.tutorialspoint.com/unix/unix-using-arrays.htm

# Arrays
# white space is important, no spaces!!
NAMES[0]="Conroy Cage"
NAMES[1]="Elijah Duran"
NAMES[2]="Jethro Jacobs"
NAMES[3]="Cletus Boggs"
NAMES[4]="Ginger Melody"
NAMES[5]="Emma Jean Faye"
NAMES[6]="Silas Filas"
NAMES[7]="Schizzle McDrizzle"
NAMES[8]="Pony Rider"

echo "First index: ${NAMES[0]}"
echo "Second index: ${NAMES[1]}"

echo "All: ${NAMES[*]}"
# echo "All: ${NAMES[@]}"

echo "All again:"
for NAME in NAMES; do
  echo "- $NAME"
done
