#!/bin/bash

# include this file in other bash scripts via
# a line like this:
# source "$(dirname "${BASH_SOURCE}")/lib/init.sh"


set -o errexit
set -o nounset
set -o pipefail


# show everything the shell is doing in case exit 1 isn't called on a fail
set -o xtrace
