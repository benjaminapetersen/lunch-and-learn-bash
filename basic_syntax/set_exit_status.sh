#!/bin/bash

if [ -d ~/ ]
then
  echo "Home ~/ is a dir"
  # set your exit status!
  exit 0
else
  echo "Home ~/ is not a dir"
  # set your exit status!
  exit 1
fi
