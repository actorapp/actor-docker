FROM ubuntu:16.04
MAINTAINER Steve Kite <steve@actor.im>

# Add Tor Repo

RUN echo 'deb http://deb.torproject.org/torproject.org xenial main' > /etc/apt/sources.list.d/tor.list \
	echo 'deb-src http://deb.torproject.org/torproject.org xenial main' >> /etc/apt/sources.list.d/tor.list
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

# Install Tor

RUN apt-get update && apt-get install -y tor deb.torproject.org-keyring

# Run Tor

EXPOSE 9050

CMD ["tor"]