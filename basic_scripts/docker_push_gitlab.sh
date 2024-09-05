#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

CONTAINER_NAME=${CONTAINER_NAME:-nodejs-auth}   # change the default?
TAG=${TAG:-latest}
GIT_HASH=$(git log -1 --pretty=%h)
USERNAME=${USERNAME:-benjaminapetersen}         # change the default?
REGISTRY=${REGISTRY:-registry.gitlab.com}       # change the default?

docker push "${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:${TAG}"

# docs for gitlab:
# https://gitlab.com/benjaminapetersen/nodejs-auth/container_registry
