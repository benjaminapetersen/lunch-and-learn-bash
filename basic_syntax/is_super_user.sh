#!/bin/bash

if [ $(id -u) = "0" ]
then
  echo "user is superuser"
  exit 0
else
  echo "user is not superuser. id is $(id -u)"
  exit 1
fi
