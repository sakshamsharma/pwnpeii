#!/usr/bin/env bash

# Place a readable copy somewhere
mkdir -p /someplace
cp /pwnpeii/mount/* /someplace
chown -R problemuser:problemusers /someplace

# Run jail
sudo cgexec -g memory,pids,cpu:ctflimit \
     sudo -u problemuser -H \
     firejail \
     --caps.drop=all \
     --net=none \
     --private \
     --noroot \
     --force \
     bash -c "
     cp /someplace/* /home/problemuser
     /home/problemuser/binary 2>&1
     " 2> /dev/null
