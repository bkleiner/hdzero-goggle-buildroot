#!/bin/bash
set -ex

FLASH_SIZE=33554432

BOARD_DIR="$(dirname $0)"
COMMON_BOARD_DIR="$(dirname $0)/../hdzgoggle_common"
source $COMMON_BOARD_DIR/functions.sh

pushd $BINARIES_DIR

cp -v $BOARD_DIR/image/*.fex .
hdz-u_boot_env_gen $BOARD_DIR/env.cfg env.fex

ENV_SIZE=$(align_size "$(stat -c%s env.fex)")
BOOT_SIZE=$(align_size "$(stat -c%s uImage)")
ROOTFS_SIZE=$(align_size "$(stat -c%s rootfs.squashfs)")
APP_SIZE=$(align_size "$(stat -c%s app.jffs2)")
OVERLAY_SIZE=4456448

cat > mbr.fex << EOF
[mbr]
size = 16

[partition_start]

[partition]
    name         = boot
    size         = $(($BOOT_SIZE / 512))
    user_type    = 0x8000

[partition]
    name         = rootfs
    size         = $(($ROOTFS_SIZE / 512)) 
    user_type    = 0x8000

[partition]
    name         = env
    size         = $(($ENV_SIZE / 512))
    user_type    = 0x8000

[partition]
    name         = app
    size         = $(($APP_SIZE / 512)) 
    user_type    = 0x8000

[partition]
    name         = overlay
    size         = $(($OVERLAY_SIZE / 512)) 
    user_type    = 0x8000
EOF
unix2dos mbr.fex
hdz-script mbr.fex
hdz-update_mbr mbr.bin 1 mbr.fex

hdz-dragonsecboot -pack boot_package.cfg

cp $BOARD_DIR/genimage.cfg .
cat >> genimage.cfg << EOF 
image flash.img {
	flash {}
	flashtype = "nor-64M"

	partition boot0 {
		image = "boot.img"
		size = 1048576
	}

	partition kernel {
		image = "uImage"
        size = $BOOT_SIZE
	}

	partition rootfs {
		image = "rootfs.squashfs"
        size = $ROOTFS_SIZE
	}

	partition env {
		image = "env.fex"
		size = $ENV_SIZE
	}
}
EOF

popd

support/scripts/genimage.sh -c $BINARIES_DIR/genimage.cfg