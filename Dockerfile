FROM debian:bullseye

LABEL \
    debian.version=bullseye

LABEL Hans Erik Fjeld <hanse.fjeld@gmail.com>

RUN set -x &&\
    apt-get update && \
    apt-get install -y --quiet \
    wget \
    unzip \
    tar \
    locales \
    git \
    make \
    autoconf \
    automake \
    flex \
    build-essential \
    libtool \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    xz-utils \
    gcc \
    cmake \
    gcc-arm-none-eabi &&\
    ldconfig 

RUN \
    echo "en_US.UTF-8 UTF-8" >/etc/locale.gen && \
    locale-gen && \
    update-locale \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ENV MY_REPOPATH="/tmp/develop"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE en_US
ARG UID=1000
ARG GUID=1000
ARG USERNAME=arm-dev

RUN \
    groupadd "${USERNAME}" --gid "${GUID}" &&\
    useradd "${USERNAME}" --uid "${UID}" --gid "${GUID}" \
    --create-home \
    --no-user-group \
    --groups sudo,dialout \
    --password ""

# Add a temporary Volume
VOLUME ["${MY_REPOPATH}"]

WORKDIR "${MY_REPOPATH}"

EXPOSE  9170

CMD ["/bin/bash"]
