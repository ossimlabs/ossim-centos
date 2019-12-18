#!/bin/bash

cd ossim-oms/joms

if [ ! -d local.properties ] ; then
    cp local.properties.template local.properties
fi

ant mvn-install

strip $OSSIM_INSTALL_PREFIX/lib64/libjoms.so
