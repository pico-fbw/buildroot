#!/bin/bash

# Generates genimage config to prepare for image generation

set -e

BOARD_DIR="$(dirname $0)/.."
BOARD_NAME="$(basename ${BOARD_DIR})"

FILES=()

for i in "${BINARIES_DIR}"/*.dtb "${BINARIES_DIR}"/rpi-firmware/*; do
	FILES+=( "${i#${BINARIES_DIR}/}" )
done

KERNEL=$(sed -n 's/^kernel=//p' "${BINARIES_DIR}/rpi-firmware/config.txt")
FILES+=( "${KERNEL}" )

BOOT_FILES=$(printf '\\t\\t\\t"%s",\\n' "${FILES[@]}")
sed "s|@BOOT_FILES@|${BOOT_FILES}|" "${BOARD_DIR}/configs/genimage.cfg.in" > "${BUILD_DIR}/genimage.cfg"
