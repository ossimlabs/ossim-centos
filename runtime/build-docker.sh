#!/bin/sh

cp ../compile-ossim/output/ossim-dist.tgz ./
docker build -t ossim-runtime-minimal-centos:local . 

