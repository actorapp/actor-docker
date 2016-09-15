#!/usr/bin/env bash

# Copying Hidden Service Keys
mkdir -p /var/lib/tor/hidden_service/
chmod 700 /var/lib/tor/hidden_service/
cp /hidden_service/* /var/lib/tor/hidden_service/

echo Hostname: `cat "/var/lib/tor/hidden_service/hostname"`

if [ "${HS_ENDPOINT:-}" ]; then
	# Building Config File
	sed -e 's/$ENDPOINT/'"$HS_ENDPOINT"'/' /etc/tor/torrc_template > /etc/tor/torrc	
else
	echo "Please, set HS_ENDPOINT environment variable!"
	exit 1
fi

tor