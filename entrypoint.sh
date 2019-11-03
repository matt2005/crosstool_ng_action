#!/bin/bash
set -e

mkdir ${INPUT_WORK_DIR}
cd ${INPUT_WORK_DIR}
if [ "${INPUT_ARCH}" == "arm9" ]; then
    cp /arm9-linux-gnueabi.config .config
else
    echo "${INPUT_ARCH} is not supported for now!"
fi
ct-ng build
cd x-tools/bin
./arm-unknown-linux-gnueabi-gcc -v
exec "$@"
