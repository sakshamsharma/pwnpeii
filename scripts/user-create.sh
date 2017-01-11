#!/usr/bin/env bash

useradd -u $1 -m ctf-$1
cp ./program/* /home/ctf-$1
