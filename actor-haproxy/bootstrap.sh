#!/usr/bin/env bash

export CERTS=$ACTOR_WEB_HOST,$ACTOR_API_HOST,$ACTOR_WS_HOST,$ACTOR_MT_HOST

/certs.sh && supervisord -n