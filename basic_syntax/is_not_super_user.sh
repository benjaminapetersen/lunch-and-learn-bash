#!/bin/bash

if [ $(id -u) != "0" ]; then
  # >&2 is a form of I/O redirection
  # We want to send errors to standard error, not standard output
  echo "You must be superuser to run this script" >&2
  exit 1
fi
