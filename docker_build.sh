#!/usr/bin/env bash

DVERSION=$(docker --version | cut -f 3 -d ' ' | cut -f 1 -d '-')

NETWORK="--network=host"

if (( $(echo "$DVERSION 1.13" | awk '{print $1 < $2}') ))
then
    NETWORK=""
fi

docker build ${NETWORK} -t pwnpeii:local .
