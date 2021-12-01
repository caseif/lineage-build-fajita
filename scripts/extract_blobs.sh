#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

OOS_PATH="${BASE_PATH}/ota/oos/oxygenos.zip"
LOS_PATH="${BASE_PATH}/ota/los/lineageos.zip"

DEVICE_NAME="fajita"
LOS_VERSION="18.1"

OOS_DOWNLOAD_URL="https://oxygenos.oneplus.net/OnePlus6TOxygen_34.J.52_OTA_052_all_2103030004_e20debb3eb584411.zip"

sudo -u $(logname) mkdir -p "${BASE_PATH}/ota/oos/images"
sudo -u $(logname) mkdir -p "${BASE_PATH}/ota/oos/mnt/system"
sudo -u $(logname) mkdir -p "${BASE_PATH}/ota/los/images"
sudo -u $(logname) mkdir -p "${BASE_PATH}/ota/los/mnt/system"

if [ "$EUID" -ne 0 ]; then
    echo "This script requires root permissions"
    exit 1
fi

if [ ! -f "${OOS_PATH}" ]; then
    echo "Downloading OxygenOS..."
    sudo -u $(logname) curl -L "${OOS_DOWNLOAD_URL}" > "${OOS_PATH}"
else
    echo "OxygenOS ROM is present; assuming up-to-date"
fi

if [ ! -f "${LOS_PATH}" ]; then
    echo "Downloading LineageOS..."
    los_download_url=$(python "$(pwd)/scripts/util/get_latest_lineage_ota_uri.py" "${DEVICE_NAME}" "${LOS_VERSION}")
    echo "Downloading from URL ${los_download_url}"
    sudo -u $(logname) curl -L "${los_download_url}" > "${LOS_PATH}"
else
    echo "LineageOS ROM is present; assuming up-to-date"
fi

if [ "${OOS_PATH}" -nt "${BASE_PATH}/ota/oos/payload.bin" ]; then
    echo "Extracting OxygenOS payload..."
    cd "${BASE_PATH}/ota/oos"
    sudo -u $(logname) unzip -o "${OOS_PATH}" "payload.bin"
else
    echo "OxygenOS payload is present; assuming up-to-date"
fi

if [ "${LOS_PATH}" -nt "${BASE_PATH}/ota/los/payload.bin" ]; then
    echo "Extracting LineageOS payload..."
    cd "${BASE_PATH}/ota/los"
    sudo -u $(logname) unzip -o "${LOS_PATH}" "payload.bin"
else
    echo "LineageOS payload is present; assuming up-to-date"
fi

if [ "${BASE_PATH}/ota/oos/payload.bin" -nt "${BASE_PATH}/ota/oos/images/vendor.img" ]; then
    echo "Extracting OxygenOS vendor.img..."
    cd "${BASE_PATH}/ota/oos"
    eval "sudo -u $(logname) ${BASE_PATH}/lineage/lineage/scripts/update-payload-extractor/extract.py" "payload.bin" --output_dir "./images" --partitions "vendor"
else
    echo "OxygenOS vendor.img is present; assuming up-to-date"
fi

cd "${BASE_PATH}/ota/los"
eval "sudo -u $(logname) ${BASE_PATH}/lineage/lineage/scripts/update-payload-extractor/extract.py" "payload.bin" --output_dir "./images"

echo "Extracting LineageOS images..."

echo "Extracting blobs..."

mount -o ro "${BASE_PATH}/ota/los/images/system.img" "${BASE_PATH}/ota/los/mnt/system/"
mount -o ro "${BASE_PATH}/ota/los/images/product.img" "${BASE_PATH}/ota/los/mnt/system/product/"
mount -o ro "${BASE_PATH}/ota/los/images/system_ext.img" "${BASE_PATH}/ota/los/mnt/system/system_ext/"
mount -o ro "${BASE_PATH}/ota/los/images/vendor.img" "${BASE_PATH}/ota/los/mnt/system/vendor/"

cd "${BASE_PATH}/lineage/device/oneplus/fajita"
sudo -u $(logname) ./extract-files.sh "${BASE_PATH}/ota/los/mnt"

umount -R "${BASE_PATH}/ota/los/mnt/system/"

echo "Done!"
