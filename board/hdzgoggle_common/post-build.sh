#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
source $BOARD_DIR/functions.sh

ensure_line "PermitRootLogin yes" "$TARGET_DIR/etc/ssh/sshd_config"