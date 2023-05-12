#!/bin/bash

GOLANG_VERSION=""
while read line; do
    if [[ "$line" == *"golang:"* ]]; then
      GOLANG_VERSION="$(echo "$line" | awk -F':' '{print $NF}')"
    fi
done < ../misc/Dockerfile.txt