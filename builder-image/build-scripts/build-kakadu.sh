#!/bin/bash

export CXXFLAGS=-DKDU_NO_THREADS

pwd
cd ossim-private/kakadu/
cd make
make -f Makefile-Linux-x86-64-gcc
#rm $(find . -name "*.so")
