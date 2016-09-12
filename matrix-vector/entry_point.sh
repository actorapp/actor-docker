#!/bin/sh
set -eu

if [ "${MATRIX_ENDPOINT:-}" ]; then
	configFile='/srv/config.json'
	echo "{ \"default_hs_url\": [ \""$MATRIX_ENDPOINT"\" ], \"default_is_url\": \"https://vector.im\", \"brand\": \"Vector\" }" > "$configFile"
else
	echo "Please, set MATRIX_ENDPOINT environment variable!"
	exit 1
fi

/usr/bin/caddy --conf /etc/Caddyfile