#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

LINK_DIR="${BASE_PATH}/lineage/build/make/tools"
TARGET_DIR="${BASE_PATH}/lineage/out/host/linux-x86"

mkdir -p "${LINK_DIR}"
mkdir -p "${TARGET_DIR}"

# This is a bit of a hack to get around running `breakfast` again to configure the PATH properly.
ln -s "${TARGET_DIR}/framework" "${LINK_DIR}/framework"
ln -s "${TARGET_DIR}/lib64" "${LINK_DIR}/lib64"
