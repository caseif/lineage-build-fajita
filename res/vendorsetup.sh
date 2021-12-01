########### extendrom section ###########
export ENABLE_EXTENDROM="true"
export EXTENDROM_SIGN_ALL_APKS="true"
export EXTENDROM_PACKAGES="SignMagisk"
export EXTENDROM_PREROOT_BOOT="true"
export BUILD_BROKEN_DUP_RULES="true"
$PWD/vendor/extendrom/get_prebuilts.sh
