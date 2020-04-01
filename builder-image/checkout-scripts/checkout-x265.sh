#!/bin/bash

set -e

X265="x265_${X265_VERSION}"
dir="${DEPS_DIR}/x265"

if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$X265.tgz -O $X265.tgz
    tar xvfz $X265.tgz
    rm -f $X265.tgz
    mv "${X265}" "${DEPS_DIR}/x265"
fi
