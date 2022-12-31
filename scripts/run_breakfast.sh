#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

PATH="$PATH:${BASE_PATH}/bin"

cd "${BASE_PATH}/lineage"
source "./build/envsetup.sh"
breakfast fajita
