#!/bin/bash

cd /work/swig

./autogen.sh
./configure prefix=/usr
make; make install
