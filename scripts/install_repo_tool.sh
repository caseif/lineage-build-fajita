#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

REPO_DOWNLOAD_URL="https://storage.googleapis.com/git-repo-downloads/repo"

mkdir -p "${BASE_PATH}/bin"

curl "${REPO_DOWNLOAD_URL}" > "${BASE_PATH}/bin/repo"
chmod a+x "${BASE_PATH}/bin/repo"
