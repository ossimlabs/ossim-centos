#!/bin/bash

cd /work/ossim-oms/joms/

if [ ! -d local.properties ] ; then
    cp local.properties.template local.properties
fi

if [ -z "${GROOVY_HOME}"] ; then
    export GROOVY_HOME=/root/.sdkman/candidates/groovy/current
fi

ant mvn-install

# Hack to fix linking on alpine
gcc -shared -Wall swig/oms_wrap.o -o libjoms.so -L$OSSIM_INSTALL_PREFIX/lib64 -lossim -loms
cp libjoms.so $OSSIM_INSTALL_PREFIX/lib64
strip $OSSIM_INSTALL_PREFIX/lib64/libjoms.so
