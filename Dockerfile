FROM debian:stable AS snapbase
LABEL maintainer "Matt Dickinson <matt@sanbridge.org>"

ENV TZ=America/New_York

#Installation of everything needed to setup snapcast
RUN apt-get update && apt-get install -y \
	git \
	build-essential \
  libasound2-dev \
  libpulse-dev \
  libvorbisidec-dev \
  libvorbis-dev \
  libopus-dev \
  libflac-dev \
  libsoxr-dev \
  alsa-utils \
  libavahi-client-dev \
  avahi-daemon \
  libexpat1-dev \
  libboost-all-dev \
  cmake \
  ccache \
  wget

RUN git clone https://github.com/badaix/snapcast.git 
#&& \
#  cd snapcast 
 
WORKDIR /snapcast


RUN make
RUN make installclient

#WORKDIR /snapcast/client
#RUN make
#RUN make install
#RUN wget https://github.com/badaix/snapcast/releases/download/v0.26.0/snapclient_0.26.0-1_without-pulse_armhf.deb
FROM debian:stable-slim AS config
#RUN wget https://github.com/badaix/snapcast/releases/download/v0.26.0/snapclient_0.26.0-1_amd64.deb

#ARG TARGETARCH

RUN apt-get update && apt-get install -y \
#RUN apt-get update && apt-get install -y \
	libasound2-dev \
  libpulse-dev \
  libvorbisidec-dev \
  libvorbis-dev \
  libopus-dev \
  libflac-dev \
  libsoxr-dev \
  alsa-utils \
  libavahi-client-dev \
  avahi-daemon \
  libexpat1-dev \
  mosquitto-clients \
  avahi-daemon \
  nano

#  man-db
 
 WORKDIR /
 
#RUN mkdir / 

COPY --from=snapbase /usr/bin/snapclient /usr/bin

#RUN mkdir /usr/share/snapclient

#COPY --from=snapbase /usr/share/snapclient /usr/share/snapclient

#COPY snapserver.conf /etc

#VOLUME /tmp
ENV SNAPCLIENT_HOST 192.168.1.198
ENV SNAPCLIENT_SOUNDCARD Headphones
#ENV LIBRESPOT_NAME librespot
#ENV LIBRESPOT_DEVICE /data/fifo
#ENV LIBRESPOT_DEVICE /tmp/snapfifo
#ENV LIBRESPOT_BACKEND pipe
#ENV LIBRESPOT_BITRATE 320
#ENV LIBRESPOT_INITVOL 100

#CMD snapclient \
#	-h "$SNAPCLIENT_HOST" \
#	-s "$SNAPCLIENT_SOUNDCARD"
#    --device "$LIBRESPOT_DEVICE" \
#    --backend "$LIBRESPOT_BACKEND" \
#    --bitrate "$LIBRESPOT_BITRATE" \
#    --initial-volume "$LIBRESPOT_INITVOL" \
#    --cache "$LIBRESPOT_CACHE" 


CMD ["--stdout", "--no-daemon", "-h 192.168.1.198"]
ENTRYPOINT ["snapclient"]

#CMD ["snapclient", "--stdout", "--no-daemon"]
##ENTRYPOINT ["/init"]


EXPOSE 1704 1705 1780
