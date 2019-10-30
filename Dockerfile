FROM debian:stable-slim

LABEL "com.github.actions.name"="Construct New Toolchain"
LABEL "com.github.actions.description"="Build toolchains with ct-ng"
LABEL "com.github.actions.icon"="fast-forward"
LABEL "com.github.actions.color"="red"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG CT_NG_BASE_URL=https://github.com/crosstool-ng/crosstool-ng.git

RUN apt-get update && apt-get install -y \
    git build-essential bison flex texinfo help2man libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch libstdc++6 gettext gperf \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

RUN git clone --recursive ${CT_NG_BASE_URL} \
    && cd crosstool-ng \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install \
    && rm -rf ../crosstool-ng/ 

COPY entrypoint.sh /entrypoint.sh
COPY arm9-linux-gnueabi.config /arm9-linux-gnueabi.config

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]