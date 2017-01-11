#!/usr/bin/env bash

function userrun() {
    cgexec -c memory:ctflimit bash -c "sudo -u problemuser /home/problemuser/runner.sh"
}

firejail \
    --noroot \
    --private \
    --caps.drop=all \
    --net=none \
    userrun
