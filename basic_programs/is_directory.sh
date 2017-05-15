#!/bin/bash

isDirectory() {
  # test
  if [ -d "$1" ]
  then
    # 0 = true
    # as `0` is the exit status of a success
    return 0
  else
    # 1 = false
    # as any number greater than `0`, from `1-255` is a fail status
    return 1
  fi
}

# running the program
if isDirectory $1;
then
  echo "yes, $1 is directory";
else
  echo "nopes, $1 is not a directory";
fi
