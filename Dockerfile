FROM debian:stable AS snapbase
LABEL maintainer "Matt Dickinson"

#Installation of everything needed to setup snapcast
RUN apt-get update && apt-get install -y \
	alsa-utils \
	avahi-daemon \
	ccache \
	cmake \
	build-essential \
	git \
	libasound2-dev \
	libpulse-dev \
	libvorbisidec-dev \
	libvorbis-dev \
	libopus-dev \
	libflac-dev \
	libsoxr-dev \
	libavahi-client-dev \
	libexpat1-dev \
	libboost-all-dev \
	wget

RUN git clone https://github.com/badaix/snapcast.git 
#&& \
#  cd snapcast 
 
WORKDIR /snapcast/client


RUN make
#RUN make installclient

FROM debian:stable-slim AS config
ARG S6_OVERLAY_VERSION=3.1.4.1

RUN apt-get update && apt-get install -y \
	alsa-utils \
	avahi-daemon \
	git \
	libasound2-dev \
	libpulse-dev \
	libvorbisidec-dev \
	libvorbis-dev \
	libopus-dev \
	libflac-dev \
	libsoxr-dev \
	libavahi-client-dev \
	libexpat1-dev \
	mosquitto-clients \
	nano \
	wget 


WORKDIR /

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

COPY --from=snapbase /usr/bin/snapclient /usr/bin

ENV TZ=America/New_York
ENV SNAPCLIENT_SOUNDCARD ""
ENV SNAPCLIENT_HOST ""
ENV HOSTID ""


CMD snapclient \
    --host "$SNAPCLIENT_HOST" \
    --soundcard "$SNAPCLIENT_SOUNDCARD" \
    --hostID "$HOSTID"	

