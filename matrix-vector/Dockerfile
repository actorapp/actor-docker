FROM alpine:3.4
MAINTAINER Steve Kite <steve@actor.im>

RUN apk add --no-cache openssh-client git libcap tar curl wget

# Caddy
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && /usr/bin/caddy -version
COPY Caddyfile /etc/Caddyfile

# Vector
RUN wget https://vector.im/packages/vector-v0.7.5-r3.tar.gz \
	&& tar -zxvf vector-v0.7.5-r3.tar.gz \
	&& cp -r vector-v0.7.5-r3/* /srv/ \
	&& rm -fr vector-v0.7.5-r3 \
	rm vector-v0.7.5-r3.tar.gz

WORKDIR /srv

EXPOSE 3000

ADD entry_point.sh /usr/bin/

ENTRYPOINT ["/usr/bin/entry_point.sh"]