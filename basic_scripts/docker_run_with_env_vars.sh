#!/bin/bash

#set -o errexit
#set -o nounset
#set -o pipefail

CONTAINER_NAME=${CONTAINER_NAME:-nodejs-auth}   # change the default?
TAG=${TAG:-latest}
GIT_HASH=$(git log -1 --pretty=%h)
USERNAME=${USERNAME:-benjaminapetersen}         # change the default?
REGISTRY=${REGISTRY:-registry.gitlab.com}       # change the default?

MONGO_USERNAME=${MONGO_USERNAME:-''}
MONGO_PASSWORD=${MONGO_PASSWORD:-''}
MONGO_PROTOCOL=${MONGO_PROTOCOL:-'mongodb'}     # change the default?
MONGO_HOST=${MONGO_HOST:-''}
MONGO_PORT=${MONGO_PORT:-'27017'}
MONGO_DATABASE=${MONGO_DATABASE:-'nodejs-auth'} # change the default?

if [ -z "$MONGO_USERNAME" || -z "MONGO_PASSWORD"]; then
  userAndPass="${MONGO_USERNAME}:${MONGO_PASSWORD}@"
fi

MONGO_URL="${MONGO_PROTOCOL}://${userAndPass}${MONGO_HOST}:${MONGO_PORT}/${MONGO_DATABASE}"

echo "MONGO_URL=${MONGO_URL}"

PORT="${PORT:-9876}"
ENV="${ENV:-dev}"


echo "Running image: ${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:${TAG}"
echo "MONGO_URL: ${MONGO_URL}"
echo "Port mapping: ${EXTERNAL_PORT}:8080"

docker run -it --rm \
  -p "${PORT}" \
  -e MONGO_USERNAME=${MONGO_USERNAME} \
  -e MONGO_PASSWORD=${MONGO_PASSWORD} \
  -e MONGO_PROTOCOL=${MONGO_PROTOCOL} \
  -e MONGO_HOST=${MONGO_HOST} \
  -e MONGO_PORT=${MONGO_PORT} \
  -e MONGO_DATABASE=${MONGO_DATABASE} \
  "${REGISTRY}/${USERNAME}/${CONTAINER_NAME}:${TAG}"
