FROM debian:stable-slim AS config

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
    wget \
    pulseaudio

RUN groupadd -g 1000 pulseaudio && useradd -u 1000 -g 1000 -d /home/pulseaudio -s /bin/bash pulseaudio

COPY pulseaudio.conf /etc/pulse/client.conf
COPY pulseaudio.service /etc/systemd/system/pulseaudio.service

RUN systemctl enable pulseaudio.service

CMD ["/sbin/init"]

FROM config AS snapbase
LABEL maintainer "Matt Dickinson"

#Installation of everything needed to setup snapcast
RUN apt-get update && apt-get install -y
