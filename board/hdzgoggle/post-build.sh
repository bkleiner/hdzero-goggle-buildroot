#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
APP_FSTAB="/dev/mmcblk0p3	/mnt/app	squashfs	ro,defaults	0 0"

mkdir -p $TARGET_DIR/mnt/app
grep -qxF $APP_FSTAB $TARGET_DIR/etc/fstab || echo $APP_FSTAB >> $TARGET_DIR/etc/fstab
