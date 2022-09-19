FROM debian:stable AS snapbase
LABEL maintainer "Matt Dickinson <matt@sanbridge.org>"

#ENV TZ=America/New_York

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
 
WORKDIR /snapcast


RUN make
RUN make installclient

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
	wget 


WORKDIR /

ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.0.1/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
#ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.2.1/s6-overlay-arm.tar.xz /tmp
#RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz 



COPY --from=snapbase /usr/bin/snapclient /usr/bin


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


#CMD ["snapclient","--stdout","--no-daemon","-h 192.168.1.198"]
#ENTRYPOINT ["snapclient"]

CMD ["snapclient","-h 192.168.1.198","--stdout","--no-daemon"]
ENTRYPOINT ["/init"]


#EXPOSE 1704 1705 1780
