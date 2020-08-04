#!/bin/bash
set -e

BASE_DIR="${PWD}"
DEPS_DIR="${PWD}/deps"

mkdir -p "${DEPS_DIR}"

docker build "$@" -t ossim-centos-builder:local . 
