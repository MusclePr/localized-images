# Ubuntu
ARG NAME="minecraft-server"
ARG TAG="latest"
FROM itzg/${NAME}:${TAG}
LABEL maintainer="MusclePr"
ARG LANG="ja_JP.UTF-8"
ARG LANGUAGE="ja_JP:ja"
RUN apt-get install -y locales && locale-gen ${LANG}
ENV LANG=${LANG}
ENV LANGUAGE=${LANGUAGE}
ENV LC_ALL=${LANG}
