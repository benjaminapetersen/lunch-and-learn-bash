#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -z "${FIRST_VAR}" ]]; then
  MY_FIRST_VAR_RESULT="Some default value because FIRST_VAR is undefined"
else
  MY_FIRST_VAR_RESULT="${FIRST_VAR}"
fi

echo "first ${MY_FIRST_VAR_RESULT}"

# or using a short-hand version

[[ -z "${SECOND_VAR}" ]] && MY_SECOND_VAR_RESULT='default' || MY_SECOND_VAR_RESULT="${SECOND_VAR}"

echo "second ${MY_SECOND_VAR_RESULT}"

# or even shorter use

MyVar="${THIRD_VAR:-default_value}"

echo "third ${THIRD_VAR}"