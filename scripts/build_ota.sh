#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

LINEAGE_KEY_PATH="${BASE_PATH}/keys/lineage/releasekey"

mkdir -p "${BASE_PATH}/built"

cd "${BASE_PATH}/lineage"

source "${BASE_PATH}/lineage/build/envsetup.sh"

export EXTENDROM_PREROOT_BOOT="true"
export EXTENDROM_PACKAGES="SignMagisk"

# This is me giving up on figuring out what the proper PATH configuration is for this script.
# Increases the build time a little bit, but it's pretty insignificant compared to compilation.
breakfast fajita

./out/soong/host/linux-x86/bin/ota_from_target_files -k "${LINEAGE_KEY_PATH}" --block "signed-target_files.zip" "${BASE_PATH}/built/lineage-19.1-$(date +%Y%m%d)-UNOFFICIAL-fajita-signed.zip"
