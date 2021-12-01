#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

LINEAGE_KEY_PATH="${BASE_PATH}/keys/lineage/releasekey.key"
PKMD_OUTPUT_DIR="${BASE_PATH}/pkmd"
PKMD_OUTPUT_PATH="${PKMD_OUTPUT_DIR}/pkmd.bin"

mkdir -p  "${PKMD_OUTPUT_DIR}"

python2 "${BASE_PATH}/lineage/external/avb/avbtool" extract_public_key --key "${LINEAGE_KEY_PATH}" --output "${PKMD_OUTPUT_PATH}"
