#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

FAJITA_DEVICE_PATCH="fajita-device-mindthegapps.patch"

mkdir -p "${BASE_PATH}/patches/gapps"
mkdir -p "${BASE_PATH}/lineage/vendor/gapps"

echo "Copying patches..."

\cp "${BASE_PATH}/../patches/gapps/${FAJITA_DEVICE_PATCH}" "${BASE_PATH}/patches/gapps"

echo "Syncing MindTheGapps repository..."

cd "${BASE_PATH}/lineage/vendor/gapps"
if [ ! -e ".git" ]; then
    git init
    git remote add origin "https://gitlab.com/MindTheGapps/vendor_gapps.git"
    git fetch origin
    git checkout -b "rho" --track "origin/rho"
else
    git pull "origin" "rho"
fi

echo "Applying MTG build script patch...."

cd "${BASE_PATH}/lineage/device/oneplus/fajita"
git restore device.mk
patch "${BASE_PATH}/lineage/device/oneplus/fajita/device.mk" "${BASE_PATH}/patches/gapps/${FAJITA_DEVICE_PATCH}"
