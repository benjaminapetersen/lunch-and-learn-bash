#!/bin/bash

#source "$(dirname "${BASH_SOURCE}")/lib/init.sh"

set -x

# TODO: working on page: http://linuxcommand.org/lc3_wss0070.php

# HOSTNAME is an environment variable.
# see all environment variables with `printenv`
title="My System Information"
# convention is to UPPERCASE variables that should be treated as constants
RIGHT_NOW=$(date +"%x %r %Z")
TIMESTAMP="Udpated on $RIGHT_NOW by $USER"
# equivalent:
#   $(command)
#   `command`

system_imfo() {
  echo "func info";
}

show_uptime() {
  echo "<h2>System uptime</h2>"
  echo "<pre>"
  uptime
  echo "</pre>"
}

drive_space() {
  echo "<h2>Filesystem space</h2>"
  echo "<pre>"
  df -h
  echo "</pre>"
}

# This is weird on a mac, just doesn't quite work the same.
# man df
# home_space() {
#   echo "<h2>Home directory space used</h2>"
#   echo "<pre>"
#   # echo "Bytes in /Downloads/ directory"
#   # linux version
#   # du -s /home/* | sort -n dr
#   # du -sh ~/*
#   # mac maybe
#   # du -d ~/Downloads/
#   echo "</pre>"
#   echo "Hello World"
# }


cat <<- _EOF_
  <html>
    <head>
      <title>$title $HOSTNAME</title>
    </head>
    <body>
      <h1>$title $HOSTNAME</h1>
      <p>$TIMESTAMP</p>
      $(system_imfo)
      $(show_uptime)
      $(drive_space)
      #$(home_space)
    </body>
  </html>
_EOF_
