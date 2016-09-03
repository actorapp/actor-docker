FROM ubuntu:16.04
MAINTAINER Steve Kite <steve@actor.im>

# Separate user for rabbitmq
RUN groupadd -r rabbitmq && useradd -r -d /var/lib/rabbitmq -m -g rabbitmq rabbitmq

# Installing RabbitMQ repo
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 0A9AF2115F4687BD29803A206B73A36E6026DFCA
RUN echo 'deb http://www.rabbitmq.com/debian testing main' > /etc/apt/sources.list.d/rabbitmq.list

# Installing RabbitMQ and its dependencies
RUN apt-get update \
		&& apt-get install -y \
			rabbitmq-server \
		&& rm -rf /var/lib/apt/lists/*

# Setting Environment Variables
# Redirect all logs to console and setting HOME to rabbitmq data directory
ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=- HOME=/var/lib/rabbitmq

# Creating all required directories
RUN mkdir -p /var/lib/rabbitmq /etc/rabbitmq \
	&& chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq \
	&& chmod 777 /var/lib/rabbitmq /etc/rabbitmq

# Installing Plugins
RUN rabbitmq-plugins enable rabbitmq_management rabbitmq_mqtt --offline

# Declare Data Volume
VOLUME /var/lib/rabbitmq

# Setting Entry Point
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

# MOAR sockets
COPY limits.conf /etc/security/

# Exposing Required Ports
EXPOSE 15672

# Starting
CMD ["rabbitmq-server"]