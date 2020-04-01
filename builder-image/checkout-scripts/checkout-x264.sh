#!/bin/bash

set -e

X264="x264-${X264_VERSION}"
dir="${DEPS_DIR}/x264"

if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$X264.tgz -O $X264.tgz
    tar xvfz $X264.tgz
    rm -f $X264.tgz
    mv "${X264}" "${DEPS_DIR}/x264"
fi
