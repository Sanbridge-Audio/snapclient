FROM debian

RUN apt-get update && apt-get install -y \
    snapclient \
    pulseaudio-utils \
    pulseaudio \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash snapclient

USER snapclient

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast

CMD ["snapclient", "-d"]
