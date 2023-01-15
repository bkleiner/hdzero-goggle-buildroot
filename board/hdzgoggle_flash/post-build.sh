#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
COMMON_BOARD_DIR="$(dirname $0)/../hdzgoggle_common"

source $COMMON_BOARD_DIR/functions.sh

mkdir -p $TARGET_DIR/rom
mkdir -p $TARGET_DIR/overlay
mkdir -p $TARGET_DIR/mnt/app

ensure_line "mmcblk([0-9]+)          root:root       660     */etc/hotplug-sdcard.sh" "$TARGET_DIR/etc/mdev.conf"
ensure_line "mmcblk([0-9]+)p([0-9]+) root:root       660     */etc/hotplug-sdcard.sh" "$TARGET_DIR/etc/mdev.conf"