#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "This script requires root permissions"
    exit 1
fi

SCRIPTS_DIR="$(dirname $0)/scripts"

source "${SCRIPTS_DIR}/util/configure_base_path.sh"

pushd .

eval "sudo -u $(logname) mkdir -p '${BASE_PATH}'"

if [ -z "${NO_REPO_SYNC}" ] || [ "${NO_REPO_SYNC}" == "0" ]; then
    echo "Installing \`repo\` tool..."
    eval "sudo -u $(logname) ${SCRIPTS_DIR}/install_repo_tool.sh ${BASE_PATH}"
    export PATH="${BASE_PATH}/bin:${PATH}"

    echo "Syncing repository..."
    eval "sudo -u $(logname) ${SCRIPTS_DIR}/sync_repo.sh ${BASE_PATH}"
fi

echo "Generating signing keys..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/generate_keys.sh ${BASE_PATH}"

echo "Running breakfast..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/run_breakfast.sh ${BASE_PATH}"

echo "Fetching GApps..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/configure_gapps.sh ${BASE_PATH}"

if [ -z "${NO_EXTRACT_BLOBS}" ] || [ "${NO_EXTRACT_BLOBS}" == "0" ]; then
    echo "Extracting blobs..."
    eval "${SCRIPTS_DIR}/extract_blobs.sh ${BASE_PATH}"
fi

echo "Patching Lineage build configurations..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/patch_lineage_build_configs.sh ${BASE_PATH}"

echo "Patching AOSP build configuration..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/patch_aosp_build_config.sh ${BASE_PATH}"

#echo "Running breakfast again..."
#eval "sudo -u $(logname) ${SCRIPTS_DIR}/run_breakfast.sh"

echo "Building LineageOS..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/compile_lineage.sh ${BASE_PATH}"

echo "Creating required symlinks..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/create_symlinks.sh ${BASE_PATH}"

echo "Signing APKs..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/sign_apks.sh ${BASE_PATH}"

echo "Building OTA package..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/build_ota.sh ${BASE_PATH}"

echo "Creating pkmd.bin..."
eval "sudo -u $(logname) ${SCRIPTS_DIR}/create_pkmd.sh ${BASE_PATH}"

popd
