#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"
COMMON_BOARD_DIR="$(dirname $0)/../hdzgoggle_common"
source $COMMON_BOARD_DIR/functions.sh

function align_size() {
    local SIZE=$1
    if (($SIZE % 65536 != 0)); then
        SIZE=$(($SIZE / 65536 + 1))
        SIZE=$(($SIZE * 65536))
    fi
    echo "$SIZE"
}

pushd $BINARIES_DIR

cp -v $BOARD_DIR/image/*.fex .
hdz-u_boot_env_gen $BOARD_DIR/env.cfg env.fex

ENV_SIZE=$(align_size "$(stat -c%s env.fex)")
BOOT_SIZE=$(align_size "$(stat -c%s uImage)")
ROOTFS_SIZE=$(align_size "$(stat -c%s rootfs.squashfs)")
APP_SIZE=$(align_size "$(stat -c%s app.jffs2)")
OVERLAY_SIZE=10485760

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


mkdir -p overlay/{upper,work}
mkfs.jffs2 --eraseblock=65536 --pad=$OVERLAY_SIZE -d overlay/ -o overlay.jffs2
rm -rf overlay

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

	partition app {
		image = "app.jffs2"
        size = $APP_SIZE 
	}

    partition overlay {
		image = "overlay.jffs2"
        size = $OVERLAY_SIZE 
	}
}
EOF

popd

support/scripts/genimage.sh -c $BINARIES_DIR/genimage.cfg