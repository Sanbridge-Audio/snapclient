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

#RUN git clone https://github.com/badaix/snapcast.git 
#&& \
#  cd snapcast 
 
#WORKDIR /snapcast


#RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.tar.bz2 && tar -xvjf boost_1_78_0.tar.bz2 \
 #&& cmake -S . -B build -DBOOST_ROOT=boost_1_78_0 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DBUILD_WITH_PULSE=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_SERVER=OFF .. \
 #&& cmake --build build --parallel 3
#RUN make
#RUN make installclient

#WORKDIR /snapcast/client
#RUN make
#RUN make install
RUN wget https://github.com/badaix/snapcast/releases/download/v0.26.0/snapclient_0.26.0-1_without-pulse_armhf.deb
#FROM debian:stable-slim AS config
RUN wgethttps://github.com/badaix/snapcast/releases/download/v0.26.0/snapclient_0.26.0-1_amd64.deb
RUN apt-get update && apt-get install -y \
#	libasound2-dev \
#  libpulse-dev \
#  libvorbisidec-dev \
#  libvorbis-dev \
#  libopus-dev \
#  libflac-dev \
#  libsoxr-dev \
#  alsa-utils \
#  libavahi-client-dev \
#  avahi-daemon \
#  libexpat1-dev \
  mosquitto-clients \
  nano \
  man-db
 

#COPY --from=snapbase /usr/bin/snapclient /usr/bin

#RUN mkdir /usr/share/snapclient

#COPY --from=snapbase /usr/share/snapclient /usr/share/snapclient

#COPY snapserver.conf /etc

#VOLUME /tmp

#CMD ["snapclient", "--stdout", "--no-daemon"]
#ENTRYPOINT ["/init"]

#EXPOSE 1704 1705 1780
