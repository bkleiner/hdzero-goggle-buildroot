#!/bin/bash
env

cp -v $BR2_EXTERNAL/board/hdzgoggle/*.fex $BINARIES_DIR/

support/scripts/genimage.sh -c $BR2_EXTERNAL/board/hdzgoggle/genimage.cfg