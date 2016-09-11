FROM ubuntu:xenial
MAINTAINER Steve Kite <steve@actor.im>

RUN echo 'deb http://matrix.org/packages/debian/ jessie main' | tee /etc/apt/sources.list.d/matrix.list
RUN apt-get clean && apt-get update && apt-get install -y --force-yes matrix-synapse

WORKDIR "/synapse"

VOLUME "/synapse"
VOLUME "/synapse-config"

EXPOSE 8008 8448

CMD ["python", "-m", "synapse.app.homeserver", "--config-path", "/synapse-config/config.yaml", "--report-stats=no"]