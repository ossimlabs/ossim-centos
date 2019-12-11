#!/bin/sh

WORK_DIR=$PWD/../work
DIST_DIR=$PWD/../dist

mkdir -p $WORK_DIR
mkdir -p $DIST_DIR

docker run -it --rm -v $PWD:/scripts -v $WORK_DIR:/work -v $DIST_DIR:/usr/local -v $OSSIM_DATA:/data ossim-runtime-centos-minimal:local 
