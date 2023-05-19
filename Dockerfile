FROM debian:stable-slim

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast
ENV TZ=America/New_York

RUN apt-get update && \
    apt-get install -y \
 --no-install-recommends \
    snapclient \
    pulseaudio-utils \
    pulseaudio && \
    rm -rf /var/lib/apt/lists/*

ARG S6_OVERLAY_VERSION=3.1.4.2

#CMD ["snapclient", "-d"]
#ENV SNAPCLIENT_SOUNDCARD sysdefault
#ENV SNAPCLIENT_HOST 192.168.1.198
#ENV HOSTID "" 
#"Pulse"
#ENV CLIENTNAME "Desktop"
  
  
 CMD snapclient \ 
     --host "$SNAPCLIENT_HOST" \ 
     --soundcard "$SNAPCLIENT_SOUNDCARD" \ 
     --hostID "$HOSTID" \
     -n "$CLIENTNAME"