#!/bin/bash
set -ex

BOARD_DIR="$(dirname $0)"

pushd $BINARIES_DIR

cp -v $BOARD_DIR/image/*.fex .
cp -v $BOARD_DIR/boot_package.cfg .

popd