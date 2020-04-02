#!/bin/bash
set -e

BASE_DIR="${PWD}"
DEPS_DIR="${PWD}/deps"
CHECKOUT_SCRIPTS_DIR="${PWD}/checkout-scripts"

mkdir -p "${DEPS_DIR}"

"${CHECKOUT_SCRIPTS_DIR}/checkout-deps.sh"

docker build -t ossim-builder-minimal-centos:local .
