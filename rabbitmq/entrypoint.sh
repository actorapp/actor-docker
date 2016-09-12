#!/bin/sh
set -eu

# Writing out erlang cookie
if [ "${RABBITMQ_ERLANG_COOKIE:-}" ]; then
	cookieFile='/var/lib/rabbitmq/.erlang.cookie'
	if [ -e "$cookieFile" ]; then
		if [ "$(cat "$cookieFile" 2>/dev/null)" != "$RABBITMQ_ERLANG_COOKIE" ]; then
			echo >&2
			echo >&2 "warning: $cookieFile contents do not match RABBITMQ_ERLANG_COOKIE"
			echo >&2
		fi
	else
		echo "$RABBITMQ_ERLANG_COOKIE" > "$cookieFile"
		chmod 600 "$cookieFile"
	fi
fi

# Creation of Default User
if [ "${RABBITMQ_ADMIN_USER:-}" ]; then
	echo "[{rabbit, [{default_user, <<\"${RABBITMQ_ADMIN_USER}\">>},{default_pass, <<\"${RABBITMQ_ADMIN_PASSWORD}\">>},{tcp_listeners, [{\"0.0.0.0\", 5672}]}]}]." > /etc/rabbitmq/rabbitmq.config
else
	echo "[{rabbit, [{default_user, <<\"admin\">>},{default_pass, <<\"actor\">>},{tcp_listeners, [{\"0.0.0.0\", 5672}]}]}]." > /etc/rabbitmq/rabbitmq.config
fi

# Fixing permissions
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

# Setting Domain and Host Names
if [ "${RABBITMQ_HOSTNAME:-}" ] || [ "${RABBITMQ_DOMAIN:-}" ]; then
	echo "Source hostname ${HOSTNAME}/`hostname -f`"
	if [ "${RABBITMQ_HOSTNAME:-}" ]; then
		export HOSTNAME="${RABBITMQ_HOSTNAME}"
	fi
	if [ "${RABBITMQ_DOMAIN:-}" ]; then
		sourceHostname="${HOSTNAME}"
		destHostname="${sourceHostname}.${RABBITMQ_DOMAIN}"
		export HOSTNAME="${destHostname}"
	fi
	echo "Setting hostname ${HOSTNAME}"
	sudo hostname "$HOSTNAME"
	echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
	echo "Hostname `hostname` set"
fi

if [ "${RABBITMQ_HOSTS:-}" ]; then
	echo "\n${RABBITMQ_HOSTS}" >> /etc/hosts
fi

# Joining cluster
if [ "${RABBITMQ_CLUSTER:-}" ]; then
	if [ ! -f /var/lib/rabbitmq/.CLUSTERED ] ; then
		echo "Trying to join cluster..."
		echo "Trying to prestart RabbitMQ"
		rabbitmq-server -detached
		sleep 10s
		echo "Stopping application"
		rabbitmqctl stop_app
		echo "Joining..."
		rabbitmqctl join_cluster "${RABBITMQ_CLUSTER}"
		touch /var/lib/rabbitmq/.CLUSTERED
		echo "Starting application to validate settings"
		rabbitmqctl start_app
		echo "Started!"
	else 
		echo "Starting..."
		rabbitmq-server
	fi
else 
	echo "Starting..."
	rabbitmq-server
fi