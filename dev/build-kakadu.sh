#!/bin/bash

cd /work/ossim-oms/joms/

if [ ! -d local.properties ] ; then
    cp local.properties.template local.properties
fi

ant mvn-install

# Hack to fix linking on alpine
gcc -shared -Wall swig/*.o -o libjoms.so -L$OSSIM_INSTALL_PREFIX/lib64 -lossim -loms
cp libjoms.so $OSSIM_INSTALL_PREFIX/lib64
strip $OSSIM_INSTALL_PREFIX/lib64/libjoms.so
