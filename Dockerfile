FROM ubuntu:14.04
MAINTAINER Tjeerd Jan van der molen <aidamina@gmail.com>

#export OPENTTD_VERSION=1.5.3
ENV OPENTTD_VERSION 1.5.3
#export OPENGFX_VERSION=0.5.2
ENV OPENGFX_VERSION 0.5.2

ENV BASE_DIR /openttd
ENV SERVER_DIR $BASE_DIR/server
ENV DATA_DIR $BASE_DIR/data
ENV TEMP_DIR /tmp
ENV SETUP source $TEMP_DIR/setup.sh &&

WORKDIR $TEMP_DIR

ADD setup.sh setup.sh
#We need this incase we build from windows
RUN sed -i 's/\r//' setup.sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN eval "$SETUP install_dependencies"
RUN eval "$SETUP install_game"
RUN eval "$SETUP setup_user"
RUN eval "$SETUP cleanup"

ENV PATH $SERVER_DIR:$PATH

WORKDIR $SERVER_DIR

EXPOSE 3979/tcp
EXPOSE 3979/udp

VOLUME ["$DATA_DIR"]

USER openttd

CMD openttd -D -c $DATA_DIR/openttd.cfg