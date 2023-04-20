#!/bin/bash
set -ex

APP_SIZE=8388608
OVERLAY_SIZE=4456448

BOARD_DIR="$(dirname $0)"
COMMON_BOARD_DIR="$(dirname $0)/../hdzgoggle_common"
source $COMMON_BOARD_DIR/functions.sh

pushd $BINARIES_DIR

cp -v $BOARD_DIR/image/*{.fex,.json} .
hdz-u_boot_env_gen $BOARD_DIR/env.cfg env.fex

cp -v uImage boot.fex
cp -v rootfs.squashfs rootfs.fex
cp -v app.jffs2 app.fex

truncate -s $APP_SIZE app.fex

mkdir -p overlay/{upper,work}
mkfs.jffs2 --eraseblock=65536 --pad=$OVERLAY_SIZE -d overlay/ -o overlay.fex
rm -rf overlay

sunxi-image dlinfo gen dlinfo.json dlinfo.fex
sunxi-image mbr gen mbr.json mbr.fex
sunxi-image image gen image.json HDZG_OS.bin

popd