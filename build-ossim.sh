#!/bin/bash

export GEOS_DIR=/usr/geos38
export GEOTIFF_DIR=/usr/libgeotiff15
export GDAL_DIR=/usr/gdal30

pushd `dirname ${BASH_SOURCE[0]}` >/dev/null
export OSSIM_DEV_HOME=`pwd -P`
export OSSIM_BUILD_DIR=$OSSIM_DEV_HOME/build
popd >/dev/null
rm -f $OSSIM_BUILD_DIR/CMakeCache.txt
# export VERBOSE=1
# export QTDIR=/usr/local/opt/qt5
# export Qt5Widgets_DIR=$QTDIR/lib/cmake/Qt5Widgets
# export Qt5Core_DIR=$QTDIR/lib/cmake/Qt5Core
# export Qt5OpenGL_DIR=$QTDIR/lib/cmake/Qt5OpenGL
export BUILD_GEOPDF_PLUGIN=OFF 
export BUILD_HDF5_PLUGIN=ON
export BUILD_OSSIM_HDF5_SUPPORT=ON
export KAKADU_ROOT_SRC=$OSSIM_DEV_HOME/ossim-private/kakadu/v7_7_1-01123C
export KAKADU_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu.a
export KAKADU_AUX_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu_aux.a
export BUILD_KML_PLUGIN=OFF
export BUILD_OSSIM_CURL_APPS=ON
export BUILD_JPEG12_PLUGIN=OFF
export BUILD_MRSID_PLUGIN=OFF
# export MRSID_DIR=$OSSIM_DEPENDENCIES/MrSID_DSDK-9.0.0.3864-darwin12.universal.gccA42 \
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

# install it
cd build
make install
cd -
