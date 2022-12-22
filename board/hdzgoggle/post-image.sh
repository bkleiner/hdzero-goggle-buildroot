#!/bin/bash
set -ex

BOARD_DIR="$BR2_EXTERNAL/board/hdzgoggle"

pushd $BINARIES_DIR

KERNEL_SIZE=$(stat -c%s uImage)
ROOTFS_SIZE=$(stat -c%s rootfs.squashfs)

cat > mbr.fex << EOF
[mbr]
size = 16

[partition_start]
[partition]
    name         = boot
    size         = $(($KERNEL_SIZE / 512))
    user_type    = 0x8000

[partition]
    name         = rootfs
    size         = $(($ROOTFS_SIZE / 512)) 
    user_type    = 0x8000
EOF

unix2dos mbr.fex
hdz-script mbr.fex
hdz-update_mbr mbr.bin 1 mbr.fex

cp -v $BOARD_DIR/*.fex .
popd

support/scripts/genimage.sh -c $BOARD_DIR/genimage.cfg