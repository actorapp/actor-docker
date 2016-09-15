FROM actor/tor-base:0.2.8.7
MAINTAINER Steve Kite <steve@actor.im>

# Writing down our config
COPY torrc_template /etc/tor/

# Writing config preprocessor
COPY bootstrap.sh /

# Hiden Service Keys
RUN mkdir /hidden_service/
VOLUME "/hidden_service/"

ENTRYPOINT ["/bootstrap.sh"]