#!/bin/bash

cd x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ../../source 
make -j 8 VERBOSE=true install
if [ $? -ne 0 ]; then echo "x265 make install error: $error" ; exit 1 ; fi
