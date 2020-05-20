#!/bin/bash

set -e

docker run --rm -i \
  -v "${PWD}/build-scripts/:/build-scripts/" \
  -v "${PWD}/ossim-repos:/work" \
  -v "${PWD}/output:/output" \
  "${BUILDER_IMAGE:=ossim-builder-minimal-centos:local}"
