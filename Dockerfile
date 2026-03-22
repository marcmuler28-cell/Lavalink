FROM ghcr.io/lavalink-devs/lavalink:latest

COPY application.yml /opt/Lavalink/application.yml

ENV PORT=2333
ENV _JAVA_OPTIONS="-Xmx256m -Xms128m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ExitOnOutOfMemoryError"

EXPOSE 2333
