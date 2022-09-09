FROM debian:stable AS snapbase
LABEL maintainer "Matt Dickinson <matt@sanbridge.org>"

ENV TZ=America/New_York

#Installation of everything needed to setup snapserver
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
  libboost-all-dev 

RUN git clone https://github.com/badaix/snapcast.git && \
  cd snapcast 

WORKDIR /snapcast

#RUN make
RUN make installclient

#FROM debian:stable-slim AS config

RUN apt-get update && apt-get install -y \
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
  nano 

#COPY --from=snapbase /usr/bin/snapclient /usr/bin

RUN mkdir /usr/share/snapclient

#COPY --from=snapbase /usr/share/snapclient /usr/share/snapclient

#COPY snapserver.conf /etc

#VOLUME /tmp

CMD ["snapclient", "--stdout", "--no-daemon"]
#ENTRYPOINT ["/init"]

EXPOSE 1704 1705 1780
