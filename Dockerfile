FROM debian

RUN apt-get update && apt-get install -y \
    snapclient \
    pulseaudio-utils \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash snapclient
USER snapclient

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast
ENV TZ=America/New_York
ENV SNAPCLIENT_SOUNDCARD ""
ENV SNAPCLIENT_HOST ""
ENV HOSTID ""

CMD ["snapclient", "--host", "$SNAPCLIENT_HOST", "--hostID", "$HOSTID"]
