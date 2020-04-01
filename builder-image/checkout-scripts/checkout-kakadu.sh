#!/bin/bash

set -e
dir="${DEPS_DIR}/ossim-private"

if [ ! -d "${dir}" ]; then
    git clone git@github.com:Maxar-Corp/ossim-private.git "${dir}"
    cd "${dir}"
    git checkout "tags/${KAKADU_VERSION}"
fi
