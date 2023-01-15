#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
COMMON_BOARD_DIR="$(dirname $0)/../hdzgoggle_common"
source $COMMON_BOARD_DIR/functions.sh

mkdir -p $TARGET_DIR/mnt/app
ensure_line "/dev/mmcblk0p3	/mnt/app	squashfs	ro,defaults	0 0" "$TARGET_DIR/etc/fstab"