#! /bin/bash
make O=$PWD/output BR2_DL_DIR=$PWD/dl BR2_EXTERNAL=$PWD -C buildroot -j$(nproc) $@