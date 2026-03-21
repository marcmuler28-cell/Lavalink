FROM ghcr.io/lavalink-devs/lavalink:latest

COPY application.yml /opt/Lavalink/application.yml

ENV PORT=2333

EXPOSE 2333
