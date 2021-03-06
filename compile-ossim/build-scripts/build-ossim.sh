#!/bin/bash

set -e

export GEOS_DIR=/usr/geos38
export GEOTIFF_DIR=/usr/libgeotiff15
export GDAL_DIR=/usr/gdal30

export OSSIM_DEV_HOME=/work
export OSSIM_DEPS_HOME=/deps
export CMAKE_CXX_FLAGS=-DKDU_NO_THREADS

pushd `dirname ${BASH_SOURCE[0]}` >/dev/null
# export OSSIM_DEV_HOME=`pwd -P`
export OSSIM_BUILD_DIR=$OSSIM_DEV_HOME/build
popd >/dev/null
rm -f $OSSIM_BUILD_DIR/CMakeCache.txt

export Qt4Core_DIR=$QTDIR/../include/QtCore
export Qt4OpenGL_DIR=$QTDIR/../include/QtOpenGL
export BUILD_OSSIM_QT4=ON

export BUILD_GEOPDF_PLUGIN=OFF
export BUILD_HDF5_PLUGIN=OFF
export BUILD_OSSIM_HDF5_SUPPORT=OFF
export KAKADU_ROOT_SRC=$OSSIM_DEPS_HOME/ossim-private/kakadu/v7_7_1-01123C
export KAKADU_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu.a
export KAKADU_AUX_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu_aux.a
export BUILD_KML_PLUGIN=OFF
export BUILD_OSSIM_CURL_APPS=ON
export BUILD_JPEG12_PLUGIN=OFF
export BUILD_MRSID_PLUGIN=OFF
export MRSID_DIR=$OSSIM_DEPENDENCIES/MrSID_DSDK-9.0.0.3864-darwin12.universal.gccA42
export BUILD_OPENJPEG_PLUGIN=OFF
export BUILD_PDAL_PLUGIN=OFF
export BUILD_GDAL_PLUGIN=ON
export BUILD_PNG_PLUGIN=ON
export BUILD_WEB_PLUGIN=ON
export BUILD_AWS_PLUGIN=OFF
export BUILD_OSSIM_PLANET_GUI=OFF
export BUILD_CSM_PLUGIN=OFF
export BUILD_KAKADU_PLUGIN=ON
export BUILD_GEOPDF_PLUGIN=OFF
export BUILD_POTRACE_PLUGIN=OFF
export BUILD_OSSIM_FRAMEWORKS=OFF
export BUILD_SQLITE_PLUGIN=OFF
export BUILD_CNES_PLUGIN=OFF
export BUILD_KML_PLUGIN=OFF
export BUILD_OPENJPEG_PLUGIN=OFF
if [ -d $OSSIM_DEV_HOME/ossim-private/ossim-kakadu-jpip-server-new ] ; then
   export OSSIM_BUILD_ADDITIONAL_DIRECTORIES=$OSSIM_DEV_HOME/ossim-private/ossim-kakadu-jpip-server-new
fi
#export CMAKE_BUILD_TYPE=RelWithDebugInfo
export CMAKE_BUILD_TYPE=Release
export BUILD_OPENCV_PLUGIN=OFF
export OSSIM_MAKE_JOBS=12

$OSSIM_DEV_HOME/ossim/scripts/build.sh


# Install it
cd build
make clean
make install

/build-scripts/build-joms.sh

for x in `find /usr/local/bin /usr/local/lib /usr/local/lib64 /usr/lib64 \
  /usr/geos38/lib64 /usr/libgeotiff15/lib /usr/gdal30/lib /usr/ogdi41/lib /usr/proj71/lib -type f`; do
  strip $x || true
done

cp -r /usr/lib64 /usr/local
mv /usr/local/lib64/mysql/* /usr/local/lib64

cp -r /usr/geos38/lib64 /usr/local/
cp -r /usr/libgeotiff15/lib /usr/local/
cp -r /usr/gdal30/lib /usr/local/
cp -r /usr/proj71/lib /usr/local/
cp -r /usr/ogdi41/lib /usr/local/

tar -cvz -C /usr/local -f /output/ossim-dist-minimal-centos.tgz .
chmod a+rw /output/ossim-dist-minimal-centos.tgz
