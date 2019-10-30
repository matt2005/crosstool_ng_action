#!/bin/bash
set -e

mkdir ${INPUT_WORK_DIR}
cd ${INPUT_WORK_DIR}
cp /arm9-linux-gnueabi.config .config
ct-ng build --silent
exec "$@"