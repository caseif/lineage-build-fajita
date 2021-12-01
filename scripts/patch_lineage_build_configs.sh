#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

PATCH_SRC_DIR="${BASE_PATH}/../patches/device"
PATCH_DIR="${BASE_PATH}/patches/device"
DEVICE_DIR="${BASE_PATH}/lineage/device/oneplus"

FAJITA_BC_PATCH="fajita-BoardConfig-avb-config.patch"
SDM845_BCC_PATCH="sdm845-BoardConfigCommon-avb-config.patch"
SDM845_COMMON_PATCH="sdm845-common-oem-unlock.patch"

mkdir -p "${PATCH_DIR}"

echo "Copying required patches..."
\cp "${PATCH_SRC_DIR}/${FAJITA_BC_PATCH}" "${PATCH_DIR}/"
\cp "${PATCH_SRC_DIR}/${SDM845_BCC_PATCH}" "${PATCH_DIR}/"
\cp "${PATCH_SRC_DIR}/${SDM845_COMMON_PATCH}" "${PATCH_DIR}/"

echo "Applying required patches..."
cd "${DEVICE_DIR}/fajita"
git restore "BoardConfig.mk"
patch "${DEVICE_DIR}/fajita/BoardConfig.mk" "${PATCH_DIR}/${FAJITA_BC_PATCH}"
cd "${DEVICE_DIR}/sdm845-common"
git restore BoardConfigCommon.mk
git restore common.mk
patch "${DEVICE_DIR}/sdm845-common/BoardConfigCommon.mk" "${PATCH_DIR}/${SDM845_BCC_PATCH}"
patch "${DEVICE_DIR}/sdm845-common/common.mk" "${PATCH_DIR}/${SDM845_COMMON_PATCH}"
