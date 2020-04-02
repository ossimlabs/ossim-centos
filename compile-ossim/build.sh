#!/bin/bash

set -e

./checkout-ossim.sh
docker run --rm -i \
-v "${PWD}/build-scripts/build-ossim.sh:/build-scripts/build-ossim.sh" \
-v "${PWD}/build-scripts/build-joms.sh:/build-scripts/build-joms.sh" \
-v "${PWD}/ossim-repos:/work" \
-v "${PWD}/output:/output" \
"${BUILDER_IMAGE:=ossim-builder-minimal-centos:local}"
