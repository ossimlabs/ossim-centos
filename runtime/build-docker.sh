#!/bin/sh

cp ../compile-ossim/output/ossim-dist-minimal-centos.tgz ./
docker build -t ossim-runtime-minimal-centos:local . 

