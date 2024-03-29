#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

PATH="$PATH:${BASE_PATH}/bin"

mkdir -p "${BASE_PATH}/lineage"

cd "${BASE_PATH}/lineage"
#git config --global user.name "user"
#git config --global user.email "user@${HOSTNAME}"
repo init "https://github.com/LineageOS/android.git" -b "lineage-19.1"
repo sync -j16
