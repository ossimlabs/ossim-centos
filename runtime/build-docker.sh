#!/bin/sh

ln ../compile-ossim/output/ossim-dist-minimal-centos.tgz ./
docker build -t ossim-centos-runtime:local "$@" . 

