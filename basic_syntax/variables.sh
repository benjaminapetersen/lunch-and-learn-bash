#!/bin/bash

# https://www.tutorialspoint.com/unix/unix-using-variables.htm

# Unix shell vars are UPPERCASE by convention
# var names can be (a-zA-z0-9_) only
# LOCAL vars are present within the current shell,
#   set at the command prompt, and are not available
#   to programs started by the shell
# ENVIRONMENT variables are available to any child
#   process of the shell. 
# SHELL variables are special vars set by the shell
#   and is required by the shell in order to 
#   function correctly.  Some of these are local
#   vars and some are environment vars

NAME="Conroy"
FULLNAME="Conroy Cage"
FAKENAME="Jethro Jacobs"
readonly FULLNAME

echo "var NAME is $NAME and FULLNAME is $FULLNAME"
echo "FULLNAME is readonly"
echo "Changing FULLNAME to 'Silas Filas'"
FULLNAME="Silas Filas"
echo "did it change? $FULLNAME"

unset FAKENAME

echo "fake name is: $FAKENAME"



