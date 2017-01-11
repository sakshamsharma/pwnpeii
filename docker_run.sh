#!/usr/bin/env bash

FOLDER=${MOUNT:-${PWD}/mount}

docker run --rm --privileged -it -p ${PORT:-9998}:9998 --net=host -v ${FOLDER}:/pwnpeii/mount pwnpeii:local
