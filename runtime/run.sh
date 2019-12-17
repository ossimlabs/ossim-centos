#!/bin/sh

WORK_DIR=$PWD/../work
DIST_DIR=$PWD/../dist

mkdir -p $WORK_DIR
mkdir -p $DIST_DIR

docker run -it --rm \
  -v $PWD:/scripts \
  -v $WORK_DIR:/work \
  -v $DIST_DIR:/usr/local \
  -v $OSSIM_DATA:/data  \
  -v $O2_DEV_HOME/omar-services/apps/omar-services-app:/omar-services \
  -p 8081:8081 \
  ossim-runtime-centos-minimal:local
