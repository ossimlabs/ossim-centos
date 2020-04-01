#!/bin/bash 

set -e

echo "@@@ Building szip"
/build-scripts/build-szip.sh

echo "@@@ Building hdf5"
/build-scripts/build-hdf5.sh

echo "@@@ Building x264"
/build-scripts/build-x264.sh

echo "@@@ Building x265"
/build-scripts/build-x265.sh

echo "@@@ Building ffmpeg"
/build-scripts/build-ffmpeg.sh

echo "@@@ Building kakadu"
/build-scripts/build-kakadu.sh

for x in `find /usr/local/bin /usr/local/lib /usr/local/lib64 -type f`; do
  strip "${x}" || true
done
