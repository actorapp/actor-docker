#!/bin/bash
set -eu

if [ ! "${GETH_DATA:-}" ]; then
	echo "Please, set GETH_DATA environment variable!"
	exit 1
fi

if [ "${GETH_GENESIS:-}" ]; then
	/usr/bin/geth --datadir=$GETH_DATA init $GETH_GENESIS
fi

if [ "${GETH_BOOTNODE_HOST:-}" ]; then
	BOOTNODE=`dig +short $GETH_BOOTNODE_HOST | tail -n1`
	echo "Boot Node found: $BOOTNODE from $GETH_BOOTNODE_HOST"
	BOOTNODE_ARGS="enode://$GETH_BOOTNODE_KEY@$BOOTNODE:30301"
	exec /usr/bin/geth --datadir=$GETH_DATA --bootnodes=$BOOTNODE_ARGS "$@"
else
	exec /usr/bin/geth --datadir=$GETH_DATA "$@"
fi