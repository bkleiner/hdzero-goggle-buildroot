#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"

mkdir -p $TARGET_DIR/mnt/app
APP_FSTAB="/dev/mmcblk0p3	/mnt/app	squashfs	ro,defaults	0 0"
grep -q $APP_FSTAB $TARGET_DIR/etc/fstab || echo $APP_FSTAB >> $TARGET_DIR/etc/fstab