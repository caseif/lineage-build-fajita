#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

LINEAGE_KEY_DIR="${BASE_PATH}/keys/lineage"
LINEAGE_KEY_PATH="${BASE_PATH}/keys/lineage/release.key"

export OUT="${BASE_PATH}/lineage/out/target/product/fajita"
export PATH="${BASE_PATH}/lineage/build/tools:${BASE_PATH}/lineage/out/host/linux-x86/bin:${PATH}"

cd "${BASE_PATH}/lineage"
source "./build/envsetup.sh"
TMPDIR=/var/tmp python2 "./build/tools/releasetools/sign_target_files_apks" -o -d "${LINEAGE_KEY_DIR}" "${OUT}/obj/PACKAGING/target_files_intermediates/"*-target_files-*.zip "signed-target_files.zip"
