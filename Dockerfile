FROM debian:stable

RUN apt-get update && apt-get install -y \
    snapclient \
    pulseaudio-utils \
    pulseaudio \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash snapclient


#RUN usermod -aG sudo snapclient 
#USER snapclient

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast

#CMD ["snapclient"]

ENV TZ=America/New_York 
# ENV SNAPCLIENT_SOUNDCARD "" 
# ENV SNAPCLIENT_HOST "" 
# ENV HOSTID "" 

USER root
RUN apt-get update && apt-get install -y \
  avahi-daemon \
  avahi-utils

RUN service avahi-daemon start

USER snapclient 
CMD ["snapclient"] 
 

 
 #CMD snapclient \ 
 #    --host "$SNAPCLIENT_HOST" \ 
 #    --soundcard "$SNAPCLIENT_SOUNDCARD" \ 
 #    --hostID "$HOSTID"        
