#!/bin/sh

# version 1: edit directly
# FILE="/etc/hosts"
FILE="./fake_etc_hosts"

TESTING_DOMAIN_NAME="iam-cluster-tests.dev"
# todo: this is fake, obviously.
PINNIPED_SUPERVISOR_IP="https://123.456.789"

echo "reading original ${FILE}..."
etcHosts=`cat ${FILE}`
echo "${etcHosts}"

echo "updating ${FILE}..."
sudo echo "${PINNIPED_SUPERVISOR_IP}     ${TESTING_DOMAIN_NAME}" > "${FILE}"

echo "verifying updated ${FILE}..."
etcHostsDuplicate=`cat ${FILE}`
echo "${etcHostsDuplicate}"


# version 2: make a duplicate file, edit, then delete & replace original
# ---------------------------------------------

# FILE_DUPLICATE="${FILE}_2"

# TESTING_DOMAIN_NAME="iam-cluster-tests.dev"
# # todo: this is fake, obviously.
# PINNIPED_SUPERVISOR_IP="https://123.456.789"

# echo "reading original ${FILE}..."
# etcHosts=`cat ${FILE}`
# echo "${etcHosts}"

# # echo "updating ${FILE_DUPLICATE}..."
# # echo "updating ${FILE_DUPLICATE}..."
# # echo "updating ${FILE_DUPLICATE}..."
# # sudo touch "${FILE_DUPLICATE}"

# # sudo echo "${etcHosts}" > "${FILE_DUPLICATE}"
# # sudo echo "${PINNIPED_SUPERVISOR_IP}     ${TESTING_DOMAIN_NAME}" > "${FILE_DUPLICATE}"

# echo "verifying updated ${FILE_DUPLICATE}..."
# etcHostsDuplicate=`cat ${FILE_DUPLICATE}`
# echo "${etcHostsDuplicate}"


# example etc host file
# ---------------------------------------------
#
# 127.0.0.1	localhost
# 127.0.1.1	ubuntu-2004

# # The following lines are desirable for IPv6 capable hosts
# ::1     ip6-localhost ip6-loopback
# fe00::0 ip6-localnet
# ff00::0 ip6-mcastprefix
# ff02::1 ip6-allnodes
# ff02::2 ip6-allrouters


## HACKERY NOTE:
## If you are unable to save it due to security policies on your computer, save it with a different name, like hosts2. Close Notepad. Delete the original hosts file and rename hosts2 to hosts.
