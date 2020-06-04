#!/bin/bash

export CXXFLAGS=-DKDU_NO_THREADS

cd ossim-private/kakadu/v7_7_1-01123C
cd make
make -f Makefile-Linux-x86-64-gcc
#rm $(find . -name "*.so")
