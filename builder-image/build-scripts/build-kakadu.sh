#!/bin/bash

export CXXFLAGS=-DKDU_NO_THREADS

ls
cd ${DEPS_DIR}/ossim-private/kakadu/
cd make
make -f Makefile-Linux-x86-64-gcc
#rm $(find . -name "*.so")
