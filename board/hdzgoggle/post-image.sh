#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"

pushd $BINARIES_DIR

hdz-u_boot_env_gen $BOARD_DIR/image/env.cfg env.fex

KERNEL_SIZE=$(stat -c%s uImage)
ROOTFS_SIZE=$(stat -c%s rootfs.ext2)
ENV_SIZE=$(stat -c%s env.fex)
APP_SIZE=$(stat -c%s app.fex)

cat > mbr.fex << EOF
[mbr]
size = 16

[partition_start]

[partition]
    name         = env
    size         = $(($ENV_SIZE / 512))
    user_type    = 0x8000

[partition]
    name         = boot
    size         = $(($KERNEL_SIZE / 512))
    user_type    = 0x8000

[partition]
    name         = rootfs
    size         = $(($ROOTFS_SIZE / 512)) 
    user_type    = 0x8000

[partition]
    name         = app
    size         = $(($APP_SIZE / 512)) 
    user_type    = 0x8000
EOF

unix2dos mbr.fex
hdz-script mbr.fex
hdz-update_mbr mbr.bin 1 mbr.fex

cp -v $BOARD_DIR/image/*.fex .

cp -v $BOARD_DIR/image/boot_package.cfg .
hdz-dragonsecboot -pack boot_package.cfg
popd

support/scripts/genimage.sh -c $BOARD_DIR/genimage.cfg