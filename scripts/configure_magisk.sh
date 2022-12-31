#!/usr/bin/bash

source "$(dirname $0)/util/configure_base_path.sh"

MAGISK_PATH="${BASE_PATH}/magisk"
MAGISK_APK_PATH="${MAGISK_PATH}/magisk.apk"
MAGISK_APK_EXTRACT_PATH="${MAGISK_PATH}/extracted"

mkdir -p "${MAGISK_PATH}"
cd "${MAGISK_PATH}"

if [ ! -f "${MAGISK_APK_PATH}" ]; then
    echo "Downloading Magisk..."
    magisk_download_url=$(python "${BASE_PATH}/../scripts/util/get_magisk_apk_uri.py")
    sudo -u $(logname) curl -L "${magisk_download_url}" > "${MAGISK_APK_PATH}"
else
    echo "Magisk APK is present; assuming up-to-date"
fi

echo "Extracting Magisk..."
rm -rf "${MAGISK_APK_EXTRACT_PATH}/*"
mkdir -p "${MAGISK_APK_EXTRACT_PATH}"
sudo -u $(logname) unzip "${MAGISK_APK_PATH}" -d "${MAGISK_APK_EXTRACT_PATH}"
