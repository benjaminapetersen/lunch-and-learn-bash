#!/bin/bash

# [] is the second syntax of the `test` command
if [ -f ~/.bash_profile ]; then
  echo "You have a .bash_profile in your home /dir. Things are peachy"
else
  echo "No .bash_profile, what what what?!?!?"
fi
