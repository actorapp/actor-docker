FROM debian:8.5
MAINTAINER Steve Kite <steve@actor.im>

RUN apt-get update && apt-get install -y coturn && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TURN_PORT 3478
ENV TURN_PORT_START 10000
ENV TURN_PORT_END 20000
ENV TURN_USERNAME actor
ENV TURN_PASSWORD password
ENV TURN_SERVER_NAME actor

ADD starter.sh starter.sh
RUN chmod +x starter.sh

CMD ["./starter.sh"]