#!/bin/bash

#set -o errexit
#set -o nounset
#set -o pipefail

# CONTAINER_NAME must be set and non-empty
: "${CONTAINER_NAME:?Need to set CONTAINER_NAME}"

TAG=${TAG:-latest}

CERTS_PATH="${PWD}/tls/"

if [ -z "$(ls -A ${CERTS_PATH})" ]; then
  echo "The path ${CERTS_PATH} must contain your certs. Run ./make_cert.sh."
  exit 1
fi

# NOTE:
# - TOKEN may be an oauth token obtained by another path and
#   then privided here as a string
# - KEY_PATH can be a path to a key.pem
# - CRT_PATH can be a path to a crt.pem
# - --mount will mount the /tls dir into /etc/tls-certs,
#   which will satisfy the need for certs to the app if
#   there are cert files in the directory. Consider
#   running make-cert.sh if a self-signed cert is needed.
docker run -it --rm \
  --mount src=${PWD}/tls/,target=/etc/tls-certs,readonly,type=bind \
  -e TOKEN=${TOKEN} \
  -e KEY_PATH=${KEY_PATH} \
  -e CRT_PATH=${CRT_PATH} \
  "${CONTAINER_NAME}:${TAG}"
