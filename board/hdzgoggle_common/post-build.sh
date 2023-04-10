#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
source $BOARD_DIR/functions.sh

ensure_line "PermitRootLogin yes" "$TARGET_DIR/etc/ssh/sshd_config"

ensure_line "rtc0          root:root       660    >rtc" "$TARGET_DIR/etc/mdev.conf"