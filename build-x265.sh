#!/bin/sh

OSSIM_DEV_HOME=/ossim
OSSIM_MAKE_JOBS=8
X265="x265_3.1.2"

#
# Setup X265
#
if [ ! -d $OSSIM_DEV_HOME/$X265 ] ; then
  pushd $OSSIM_DEV_HOME
  wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$X265.tgz -O $X265.tgz
  tar xvfz $X265.tgz
  rm -f $X265.tgz
  popd > /dev/null
fi

if [ -d $OSSIM_DEV_HOME/$X265 ] ; then
   cd $OSSIM_DEV_HOME/$X265/build/linux
   cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ../../source 
   make -j $OSSIM_MAKE_JOBS VERBOSE=true install
   if [ $? -ne 0 ]; then echo "x265 make install error: $error" ; exit 1 ; fi
else
   echo "Error: $OSSIM_DEV_HOME/$X265.tgz Not found.  Please edit the common.sh to specify the proper version then place the version under https://s3.amazonaws.com/ossimlabs/dependencies/source/"
   exit 1  
fi
