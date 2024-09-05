#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

CONTAINER_NAME=${CONTAINER_NAME:-nodejs-auth}   # change the default?
TAG=${TAG:-latest}
GIT_HASH=$(git log -1 --pretty=%h)
USERNAME=${USERNAME:-benjaminapetersen}         # change the default?
REGISTRY=${REGISTRY:-registry.gitlab.com}       # change the default?

echo "building ${CONTAINER_NAME}:${TAG} from ${PWD}"
echo "tagging ${CONTAINER_NAME} as ${USERNAME}/${CONTAINER_NAME}:${TAG}"
echo "tagging ${CONTAINER_NAME} as ${USERNAME}/${CONTAINER_NAME}:git${GIT_HASH}"
echo "tagging ${CONTAINER_NAME} as ${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:${TAG}"
echo "tagging ${CONTAINER_NAME} as ${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:git${GIT_HASH}"


# build a local & a namespaced version
docker build -t "${CONTAINER_NAME}:${TAG}" "${PWD}"
docker tag "${CONTAINER_NAME}:${TAG}" "${USERNAME}/${CONTAINER_NAME}:${TAG}"
docker tag "${CONTAINER_NAME}:${TAG}" "${USERNAME}/${CONTAINER_NAME}:git${GIT_HASH}"
docker tag "${CONTAINER_NAME}:${TAG}" "${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:${TAG}"
docker tag "${CONTAINER_NAME}:${TAG}" "${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:git${GIT_HASH}"

echo ''
echo ''

docker images | grep "${CONTAINER_NAME}"
