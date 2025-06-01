# Ubuntu
ARG BASE_IMAGE="itzg/minecraft-server"
ARG TAG="latest"
FROM ${BASE_IMAGE}:${TAG}
LABEL maintainer="MusclePr"
ARG LANG="ja_JP.UTF-8"
ARG LANGUAGE="ja_JP:ja"
RUN if [ -f /etc/alpine-release ]; then \
        apk update && apk add musl-locales musl-locales-lang && \
        echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/locale.sh; \
    else \
        apt-get update && apt-get install -y locales && locale-gen ${LANG}; \
    fi
ENV LANG=${LANG}
ENV LANGUAGE=${LANGUAGE}
ENV LC_ALL=${LANG}
