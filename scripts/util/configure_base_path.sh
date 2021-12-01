#!/usr/bin/env bash

if [ $# -ge 1 ]; then
    BASE_PATH="$1"
else
    BASE_PATH="$(pwd)/lineage_workspace"
fi

eval "sudo -u $(logname) mkdir -p '${BASE_PATH}'"
