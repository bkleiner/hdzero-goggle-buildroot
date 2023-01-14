#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"

mkdir -p $TARGET_DIR/rom
mkdir -p $TARGET_DIR/overlay
mkdir -p $TARGET_DIR/mnt/app