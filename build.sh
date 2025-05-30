#!/bin/bash

function build()
{
    docker build . --build-arg NAME="${1}" --build-arg TAG="${2}" -t "MusclePr/${1}:${2}"
}

TAGS=(java17 latest)

for TAG in ${TAGS[*]}; do
  build "minecraft-server" "${TAG}"
done
build "mc-proxy" latest
