FROM debian:stable-slim

ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
ENV PULSE_SINK=snapcast
ENV TZ=America/New_York

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    snapclient \
    pulseaudio-utils \
    pulseaudio && \
    rm -rf /var/lib/apt/lists/*

CMD ["snapclient", "-d"]
