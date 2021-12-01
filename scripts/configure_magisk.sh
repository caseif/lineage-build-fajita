#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

FAJITA_BC_PATCH="fajita_BoardConfig_custom_bootimg.patch"
FAJITA_DEVICE_PATCH="fajita_device_enable_extendrom.patch"

echo "Copying required files..."

mkdir -p "${BASE_PATH}/patches/magisk"
mkdir -p "${BASE_PATH}/lineage/vendor/extendrom"
#mkdir -p "${BASE_PATH}/lineage/.repo/local_manifests"

\cp "${BASE_PATH}/../res/extendrom.xml" "${BASE_PATH}/lineage/.repo/local_manifest/"
\cp "${BASE_PATH}/../res/mkbootimg.mk" "${BASE_PATH}/lineage/device/oneplus/fajita"

\cp "${BASE_PATH}/../patches/magisk/${FAJITA_BC_PATCH}" "${BASE_PATH}/patches/magisk/${FAJITA_BC_PATCH}"
\cp "${BASE_PATH}/../patches/magisk/${FAJITA_DEVICE_PATCH}" "${BASE_PATH}/patches/magisk/${FAJITA_DEVICE_PATCH}"

echo "Patching build files..."
patch "${BASE_PATH}/lineage/device/oneplus/fajita/BoardConfig.mk" "${BASE_PATH}/patches/magisk/${FAJITA_BC_PATCH}"
patch "${BASE_PATH}/lineage/device/oneplus/fajita/device.mk" "${BASE_PATH}/patches/magisk/${FAJITA_DEVICE_PATCH}"

echo "Syncing extendrom repository..."

cd "${BASE_PATH}/lineage/vendor/extendrom"
if [ ! -e ".git" ]; then
    git init
    git remote add origin "https://github.com/sfX-android/android_vendor_extendrom.git"
    git fetch origin
    git checkout -b "main" --track "origin/main"
else
    git pull "origin" "main"
fi

echo "Running breakfast..."
eval "${BASE_PATH}/scripts/run_breakfast.sh"

#repo sync -j12 "vendor/extendrom"
