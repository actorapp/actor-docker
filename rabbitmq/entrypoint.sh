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
if [ ! -f /.USER_INITED ] ; then
	if [ "${RABBITMQ_ADMIN_USER:-}" ]; then
		echo "First run: creating default user '${RABBITMQ_ADMIN_USER}'"
		echo "[{rabbit, [{default_user, <<\"${RABBITMQ_ADMIN_USER}\">>},{default_pass, <<\"${RABBITMQ_ADMIN_PASSWORD}\">>},{tcp_listeners, [{\"0.0.0.0\", 5672}]}]}]." > /etc/rabbitmq/rabbitmq.config
	else
		echo "First run: creating default user 'admin'"
		echo "[{rabbit, [{default_user, <<\"admin\">>},{default_pass, <<\"actor\">>},{tcp_listeners, [{\"0.0.0.0\", 5672}]}]}]." > /etc/rabbitmq/rabbitmq.config
	fi
	touch /.USER_INITED
fi

# Fixing permissions
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

exec "$@"