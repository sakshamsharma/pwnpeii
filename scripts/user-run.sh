#!/usr/bin/env bash

# Run jail
sudo cgexec -g memory:ctflimit \
     sudo -u problemuser -H \
     firejail \
     --caps.drop=all \
     --net=none \
     --noroot \
     --force \
     bash -c "
     /home/problemuser/runner.sh 2>&1
     " 2> /dev/null
