#!/bin/bash

function build()
{
  # 引数からイメージ名とプロジェクト名を取得
  local IMAGE="${1}"
  local PROJECT="${2:-$(basename ${1})}"
  docker build . --build-arg IMAGE="${IMAGE}" -t "ghcr.io/musclepr/${PROJECT}"
}

if [ "$1" = "all" ]; then
  IMAGES=(
    "itzg/minecraft-server:latest"
    # "itzg/minecraft-server:java25" # ... Java 25 は、latest と同じなので、使用しない
    "itzg/minecraft-server:java21"
    "itzg/minecraft-server:java17"
    "itzg/mc-proxy:latest"
    "itzg/mc-proxy:java25" # ... latest が Java 21 のままのため、新規追加
    "itzg/mc-backup:latest"
    # "hermsi/ark-server:latest" # ... TZを変更するだけで、GameUserSettings.ini が起動中に文字化けしたので、使用しない
  )
else
  IMAGES=("$@")
fi
for IMAGE in "${IMAGES[@]}"; do
  build "${IMAGE}"
done
