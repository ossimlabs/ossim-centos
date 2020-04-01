#!/bin/bash

set -e

FFMPEG="ffmpeg-${FFMPEG_VERSION}"
dir="${DEPS_DIR}/ffmpeg"

if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$FFMPEG.tgz -O $FFMPEG.tgz
    tar xvfz $FFMPEG.tgz
    rm -f $FFMPEG.tgz
    mv "${FFMPEG}" "${DEPS_DIR}/ffmpeg"
fi
