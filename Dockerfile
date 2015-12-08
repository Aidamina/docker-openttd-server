FROM ubuntu:14.04
MAINTAINER Tjeerd Jan van der molen <aidamina@gmail.com>

#export OPENTTD_VERSION=1.5.3
ENV OPENTTD_VERSION 1.5.3

RUN sudo apt-get update 
RUN apt-get install -y \
	wget \
	xz-utils \
	libsdl-image1.2 \
	libfontconfig1

RUN wget -qO- https://binaries.openttd.org/releases/$OPENTTD_VERSION/openttd-$OPENTTD_VERSION-linux-generic-amd64.tar.xz | tar -xJC /tmp/

ENV PATH /tmp/openttd-$OPENTTD_VERSION-linux-generic-amd64:$PATH

WORKDIR /tmp/openttd-$OPENTTD_VERSION-linux-generic-amd64

EXPOSE 3979/tcp
EXPOSE 3979/udp


CMD ["openttd","-D"]