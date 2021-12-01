#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

export TARGET_BUILD_VARIANT=user

export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)

ccache -M 50G
ccache -o compression=true
ccache -s cache

pushd .
cd "${BASE_PATH}/lineage"
source "./build/envsetup.sh"
croot
echo "Running breakfast again..."
breakfast fajita
echo "Starting compile..."
export EXTENDROM_PREROOT_BOOT="true"
export EXTENDROM_PACKAGES="SignMagisk"
mka target-files-package otatools -j12
popd
