#!/bin/sh
MOUNTPOINT=/mnt/extsd

case $ACTION in
remove)
        /bin/umount -l $MOUNTPOINT || true
        ;;
*)
        /bin/mkdir $MOUNTPOINT > /dev/null 2>&1 || true
        /sbin/fsck.vfat -y /dev/$MDEV > /dev/null 2>&1 || true
        /bin/mount -o sync -o noatime -o nodiratime /dev/$MDEV $MOUNTPOINT > /dev/null 2>&1 || true
        ;;
esac

exit 0