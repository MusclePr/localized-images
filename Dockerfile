# Ubuntu
ARG NAME="minecraft-server"
FROM itzg/${NAME}:latest
LABEL maintainer="MusclePr"
ARG LANG="ja_JP.UTF-8"
ARG LANGUAGE="ja_JP:ja"
RUN apt-get install -y locales && locale-gen ${LANG}
ENV LANG=${LANG}
ENV LANGUAGE=${LANGUAGE}
ENV LC_ALL=${LANG}
