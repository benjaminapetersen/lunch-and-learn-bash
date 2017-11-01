#!/bin/bash

# http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-2.html

# -c = chdir, change directory
# -Z = zip? dunno. archives encrypted file system info
#      with the encrypted files & directories
# -f = file? use the archive var as the archive to be read or written

# TODO: these do not work
# tar -cZf ~/backups/my-backup.tgz ./
# tar -cZf ./ ~/backups/my-backup.tgz
