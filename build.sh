#!/bin/bash
function build()
{
    docker build . --build-arg NAME="${1}" -t "MusclePr/${1}:latest"
}

build "minecraft-server"
build "mc-proxy"
