#!/bin/sh

OSSIM_DEV_HOME=/ossim
OSSIM_MAKE_JOBS=8

HDF5="hdf5-1.10.5"
 
#
# Setup hdf5
#
if [ ! -d $OSSIM_DEV_HOME/$HDF5 ] ; then
  pushd $OSSIM_DEV_HOME
  wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$HDF5.tgz -O $HDF5.tgz
  tar xvfz $HDF5.tgz
  rm -f $HDF5.tgz
  popd > /dev/null
fi

if [ -d $OSSIM_DEV_HOME/$HDF5 ] ; then
   cd $OSSIM_DEV_HOME/$HDF5
   mkdir -p build
   cd build
   cmake3 \
   -DCMAKE_INSTALL_PREFIX=/usr/local \
   -DSZIP_LIBRARY=/usr/local/lib/libszip.a \
   -DSZIP_INCLUDE_DIR=/usr/local/include \
   -DSZIP_DIR=/usr/local \
   -DBUILD_TESTING=OFF \
   -DCMAKE_BUILD_TYPE=Release \
   -DHDF5_BUILD_CPP_LIB=ON \
   -DHDF5_BUILD_EXAMPLES=OFF \
   -DHDF5_BUILD_FORTRAN=OFF \
   -DHDF5_BUILD_HL_LIB=OFF \
   -DHDF5_BUILD_TOOLS=OFF \
   -DHDF5_ENABLE_Z_LIB_SUPPORT=ON \
   -DHDF5_ENABLE_SZIP_SUPPORT=ON \
   ..

   make VERBOSE=1 -j $OSSIM_MAKE_JOBS install
   if [ $? -ne 0 ]; then echo "hdf5 make install error: $error" ; exit 1 ; fi
 
else
   echo "Error: $OSSIM_DEV_HOME/$HDF5.tgz Not found.  Please edit the common.sh to specify the proper version then place the version under https://s3.amazonaws.com/ossimlabs/dependencies/source/"
   exit 1  
fi
