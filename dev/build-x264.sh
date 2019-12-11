#!/bin/sh

OSSIM_DEV_HOME=/work
OSSIM_MAKE_JOBS=8
X264="x264-0.155-20180923-545de2f"

#
# Setup X264
#
if [ ! -d $OSSIM_DEV_HOME/$X264 ] ; then
  pushd $OSSIM_DEV_HOME
  wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$X264.tgz -O $X264.tgz
  tar xvfz $X264.tgz
  rm -f $X264.tgz
  popd > /dev/null
fi

if [ -d $OSSIM_DEV_HOME/$X264 ] ; then
   cd $OSSIM_DEV_HOME/$X264
   ./configure --enable-shared --prefix=/usr/local --disable-asm
   make -j $OSSIM_MAKE_JOBS install install-lib-static install-lib-shared
   if [ $? -ne 0 ]; then echo "x264 install error: $error" ; exit 1 ; fi
else
   echo "Error: $OSSIM_DEV_HOME/$X264 Not found.  Please edit the common.sh to specify the proper version then place the version under https://s3.amazonaws.com/ossimlabs/dependencies/source/"
   exit 1  
fi
