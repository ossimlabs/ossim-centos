#!/bin/bash

set -e

export KAKADU_VERSION="OrchidIsland-2.11.1"
export FFMPEG_VERSION="4.2"
export HDF5_VERSION="1.10.5"
export SZIP_VERSION="2.1.1"
export X264_VERSION="0.155-20180923-545de2f"
export X265_VERSION="3.1.2"

export DEPS_DIR="${PWD}/deps"

dir="$(dirname $0)"

"${dir}/checkout-kakadu.sh"
"${dir}/checkout-ffmpeg.sh"
"${dir}/checkout-hdf5.sh"
"${dir}/checkout-szip.sh"
"${dir}/checkout-x264.sh"
"${dir}/checkout-x265.sh"
