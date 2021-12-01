#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

AOSP_MAKEFILE_PATCH_PATH="${BASE_PATH}/patches/core-Makefile-fix-18.1.patch"

AOSP_MAKEFILE_PATCH_URL="https://raw.githubusercontent.com/Wunderment/build_tasks/master/source/core-Makefile-fix-18.1.patch"

mkdir -p "${BASE_PATH}/patches"

echo "Acquiring AOSP buildscript patches..."
curl "${AOSP_MAKEFILE_PATCH_URL}" > "${AOSP_MAKEFILE_PATCH_PATH}"

echo "Applying AOSP buildscript patches..."
cd "${BASE_PATH}/lineage/build/core"
git restore "Makefile"
patch "${BASE_PATH}/lineage/build/core/Makefile" "${AOSP_MAKEFILE_PATCH_PATH}"
