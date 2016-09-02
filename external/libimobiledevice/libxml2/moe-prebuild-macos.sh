#!/bin/bash

set -e

if [ -z "$MOE_PREBUILTS_DIR" ]; then
    echo "MOE_PREBUILTS_DIR env var is not set" 1>&2
    exit 1
fi
echo "MOE_PREBUILTS_DIR=$MOE_PREBUILTS_DIR"

if [ -z "$MOE_PREBUILTS_TARGET_DIR" ]; then
    echo "MOE_PREBUILTS_TARGET_DIR env var is not set" 1>&2
    exit 1
fi
echo "MOE_PREBUILTS_TARGET_DIR=$MOE_PREBUILTS_TARGET_DIR"

# Clean old build
rm -rf "$MOE_PREBUILTS_DIR/$MOE_PREBUILTS_TARGET_DIR"

git apply libxml_v291.patch

__MOE_TARGET="$MOE_PREBUILTS_DIR/$MOE_PREBUILTS_TARGET_DIR"

./autogen.sh \
--prefix="$__MOE_TARGET" \
--disable-shared \
CFLAGS="-DMOE" \
--with-python=no
make
make install
