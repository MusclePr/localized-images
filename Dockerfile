# Ubuntu
ARG IMAGE="itzg/minecraft-server:latest"
FROM ${IMAGE}
LABEL maintainer="MusclePr"
ARG LANG="ja_JP.UTF-8"
ARG LANGUAGE="ja_JP:ja"
RUN if [ -f /etc/alpine-release ]; then \
        apk update && apk add --no-cache musl-locales musl-locales-lang && \
        echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/locale.sh; \
    else \
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales && \
        # enable ja_JP.UTF-8 in /etc/locale.gen then generate and set it as default
        sed -i 's/^# *\(ja_JP.UTF-8 UTF-8\)/\1/' /etc/locale.gen && \
        locale-gen ${LANG} && update-locale LANG=${LANG} && \
        apt-get -qq autoclean && apt-get -qq autoremove && rm -rf /var/lib/apt/lists/*; \
    fi
ENV LANG=${LANG}
ENV LANGUAGE=${LANGUAGE}
ENV LC_ALL=${LANG}
