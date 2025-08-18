#!/bin/bash

function build()
{
  # 引数からイメージ名とプロジェクト名を取得
  local IMAGE="${1}"
  local PROJECT="${2:-$(basename ${1})}"
  docker build . --build-arg IMAGE="${IMAGE}" -t "ghcr.io/musclepr/${PROJECT}"
}

build "itzg/minecraft-server:latest"
build "itzg/minecraft-server:java17"
build "itzg/mc-proxy:latest"
build "itzg/mc-backup:latest"
