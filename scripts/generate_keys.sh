#!/usr/bin/env bash

source "$(dirname $0)/util/configure_base_path.sh"

KEY_DIR="${BASE_PATH}/keys/lineage"
LINEAGE_KEY_PATH="${KEY_DIR}/releasekey"

mkdir -p "${BASE_PATH}/keys"
mkdir -p "${BASE_PATH}/keys/lineage"

subject='/C=US/ST=Maryland/L=Frederick/O=Private/OU=Private/CN=Max Roncace/emailAddress=me@caseif.net'

for keyname in releasekey platform shared media networkstack; do \
    "${BASE_PATH}/lineage/development/tools/make_key" "${KEY_DIR}/$keyname" "${subject}"; \
done

openssl pkcs8 -in "${LINEAGE_KEY_PATH}.pk8" -inform DER -out "${LINEAGE_KEY_PATH}.key" -nocrypt
openssl rsa -in "${LINEAGE_KEY_PATH}.key" -pubout -out "${LINEAGE_KEY_PATH}.key.pub"
