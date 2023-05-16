FROM debian:stable

RUN apt-get update && apt-get install -y \
    snapclient \
    pulseaudio-utils \
    pulseaudio \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash snapclient

USER snapclient

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast

#CMD ["snapclient"]

ENV TZ=America/New_York 
# ENV SNAPCLIENT_SOUNDCARD "" 
# ENV SNAPCLIENT_HOST "" 
# ENV HOSTID "" 

RUN apt-get update && apt-get install -y avahi-daemon
RUN service avahi-daemon start

CMD ["snapclient"] 
 
  
#CMD /bin/bash -c "snapclient && avahi-daemon -D"
 
 #CMD snapclient \ 
 #    --host "$SNAPCLIENT_HOST" \ 
 #    --soundcard "$SNAPCLIENT_SOUNDCARD" \ 
 #    --hostID "$HOSTID"        
