#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"

SSH_PERMIT_LOGIN="PermitRootLogin yes"
grep -q "$SSH_PERMIT_LOGIN" "$TARGET_DIR/etc/ssh/sshd_config" || echo "$SSH_PERMIT_LOGIN" >> "$TARGET_DIR/etc/ssh/sshd_config"