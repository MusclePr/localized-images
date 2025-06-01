#!/bin/bash

function build()
{
    local BASE_IMAGE="${1}"
    local PROJECT="${2}"
    local TAG="${3}"
    docker build . --build-arg BASE_IMAGE="${BASE_IMAGE}" --build-arg TAG="${TAG}" -t "MusclePr/${PROJECT}:${TAG}"
}

TAGS=(java17 latest)

for TAG in ${TAGS[*]}; do
  build "itzg/minecraft-server" "minecraft-server" "${TAG}"
done
build "itzg/mc-proxy" "mc-proxy" "latest"
build "itzg/mc-backup" "mc-backup" "latest"
