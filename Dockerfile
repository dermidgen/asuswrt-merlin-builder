FROM ubuntu:18.04

###############################################################################
## Based on instructions from:
## https://www.snbforums.com/threads/asus-rt-ac86u-and-luks-firmware-384-8_2.60668/#post-533466
## https://github.com/RMerl/asuswrt-merlin/wiki/Compiling-from-source-using-a-Debian-based-Linux-Distribution
## https://github.com/RMerl/asuswrt-merlin/wiki/Compile-Firmware-from-source-using-Ubuntu
###############################################################################

ENV WORKDIR /opt/merlin
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p $WORKDIR
WORKDIR ${WORKDIR}

RUN rm -f /bin/sh && ln -sf bash /bin/sh

RUN dpkg --add-architecture i386 

RUN apt-get update && \
    apt-get -y dist-upgrade

RUN apt-get -y install \
      autoconf \
      autogen \
      automake \
      automake1.11 \
      autopoint \
      bash \
      bison \
      build-essential \
      bzip2 \
      cmake \
      curl \
      cvs \
      diffutils \
      file \
      flex \
      g++ \
      g++-multilib \
      gawk \
      gcc-multilib \
      gconf-editor \
      gettext \
      git \
      gitk \
      gperf \
      groff-base \
      gtk-doc-tools \
      intltool \
      lib32stdc++6 \
      lib32z1-dev \
      libelf-dev:i386 \
      libelf1 \
      libelf1:i386 \
      libexpat1-dev \
      libglib2.0-dev \
      libltdl-dev \
      liblzo2-dev \
      libncurses5 \
      libncurses5-dev \
      libproxy-dev \
      libslang2 \
      libssl-dev \
      libtool \
      libtool-bin \
      libvorbis-dev \
      libxml-parser-perl \
      libxml2-dev \
      linux-headers-$(uname -r) \
      lsb-release \
      lzip \
      m4 \
      make \
      mtd-utils \
      patch \
      patchelf \
      perl \
      pkg-config \
      python \
      sed \
      shtool \
      subversion \
      tar \
      texinfo \
      unzip \
      uuid-dev \
      wget \
      xsltproc \
      xutils-dev \
      zlib1g \
      zlib1g-dev
