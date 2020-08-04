#!/bin/bash
set -e

BASE_DIR="${PWD}"
DEPS_DIR="${PWD}/deps"

mkdir -p "${DEPS_DIR}"

"${CHECKOUT_SCRIPTS_DIR}/checkout-deps.sh"

docker build "$@" -t ossim-centos-builder:local . 
