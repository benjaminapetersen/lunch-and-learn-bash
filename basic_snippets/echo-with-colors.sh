#!/bin/bash

# super basic color vars with echos
# I've used these many times, including in:
# https://github.com/benjaminapetersen/console-operator/blob/16a051ed27866bb3c531002083d9efd22bd6a8c9/contrib/cluster_configure.sh
# but functions would be better
YELLOW="\e[93m"
GRAY="\e[33m"
RESET="\e[97m"

echo -e "${YELLOW}Doing a thing${RESET}"
echo -e "${GRAY}Another Thing${RESET}"

# 3 functions borrowed from
# https://github.com/vmware-tanzu/pinniped/blob/main/hack/lib/helpers.sh
function log_note() {
  GREEN='\033[0;32m'
  NC='\033[0m'
  if [[ ${COLORTERM:-unknown} =~ ^(truecolor|24bit)$ ]]; then
    echo -e "${GREEN}$*${NC}"
  else
    echo "$*"
  fi
}

function log_error() {
  RED='\033[0;31m'
  NC='\033[0m'
  if [[ ${COLORTERM:-unknown} =~ ^(truecolor|24bit)$ ]]; then
    echo -e "🙁${RED} Error: $* ${NC}"
  else
    echo ":( Error: $*"
  fi
}

function check_dependency() {
  if ! command -v "$1" >/dev/null; then
    log_error "Missing dependency..."
    log_error "$2"
    exit 1
  fi
}
