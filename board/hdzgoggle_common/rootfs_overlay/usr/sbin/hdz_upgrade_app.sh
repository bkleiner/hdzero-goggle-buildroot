#! /bin/bash
set -ex

IMG_TO_OTA="app"
UPDATE_FOLDER="/tmp/goggle_update"

OTA_PACKAGE=$UPDATE_FOLDER/hdzgoggle_app_ota.tar
[ ! -f $OTA_PACKAGE ] && echo "$OTA_PACKAGE not exist" && exit -1

MTDPART="$(cat /proc/mtd | grep app | cut -d ':' -f1)"
MTDSIZE="$(cat /proc/mtd | grep app | cut -d ' ' -f2)"
if [ x"$MTDPART" == x"" ]; then
    echo "mtd part not found"
    exit -1
fi

MTDDEV="/dev/$MTDPART"

UPDATE_FILE="$UPDATE_FOLDER/$IMG_TO_OTA.fex"
tar -xf "$OTA_PACKAGE" "$IMG_TO_OTA.fex" -O > "$UPDATE_FILE"

UPDATE_SIZE="$(du -sb "$UPDATE_FILE" | awk '{ print $1 }')"

mtd_debug erase "$MTDDEV" 0 "0x$MTDSIZE"
mtd_debug write "$MTDDEV" 0 "$UPDATE_SIZE" "$UPDATE_FILE"

rm $UPDATE_FILE
rm $OTA_PACKAGE