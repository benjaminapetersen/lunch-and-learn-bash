#!/bin/bash

# man test
# -d `is directory?`
# -f `is file?`
# -e `file exists?`
# -L `file is a symbolic link?`
# -r `file is readable? (by you)`
# -w `file is writable? (by you)`
# -x `file is executable? (by you)`
# -z `true if string is empty`
# -n `true if string is not empty`


# first form of test
# seems to be less in use
if test -e ~/.bash_profile; then
  echo "You have a .bash_profile. Things are fine."
else
  echo "Yikes! You have no .bash_profile!"
fi

# second form of test
# seems to be used more frequently
if [ -f ~/.bash_profile ]; then
    echo "You have a .bash_profile. Things are fine."
else
    echo "Yikes! You have no .bash_profile!"
fi
    
