#!/bin/sh
docker run -it --rm \
-v $PWD:/scripts \
-v $OSSIM_DATA:/data \
-v $PWD/work:/work \
-v $PWD/dist:/usr/local \
ossim-centos-dev $*
