#!/bin/sh

docker run -it --rm \
  -v $OSSIM_DATA:/data  \
  -v $O2_DEV_HOME/omar-services/apps/omar-services-app:/omar-services \
  -p 8081:8081 \
  ossim-runtime-minimal:alpine $*
