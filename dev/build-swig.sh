#!/bin/bash

cd /work/ossim-private/kakadu/${KAKADU_VERSION}

for x in $(grep -l pthread_yield\(\)  $(find . -type f)); do 
    sed -i 's/pthread_yield();/sched_yield();/g' $x
done

cd make
make -f Makefile-Linux-x86-64-gcc