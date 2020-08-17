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

#export VERBOSE=1
#export QTDIR=/usr/local/opt/qt4
#export Qt4Widgets_DIR=$QTDIR/lib/cmake/Qt4Widgets
#export Qt4Core_DIR=$QTDIR/lib/cmake/Qt4Core
#export Qt4OpenGL_DIR=$QTDIR/lib/cmake/Qt4OpenGL
#export BUILD_OSSIM_QT4=ON

#
if [ -f $OSSIM_DEV_HOME/ossim-deps-$TYPE-all.tgz ] ; then
   cd /usr/local
   tar xvfz $OSSIM_DEV_HOME/ossim-deps-$TYPE-all.tgz
   export OSSIM_DEPENDENCIES=/usr/local
else
   export OSSIM_DEPENDENCIES=$OSSIM_DEV_HOME/ossim-dependencies
fi

if [ -f $OSSIM_DEV_HOME/qt4-${TYPE}.tgz ]; then
   echo; echo "*** Building with QT4 ***"; echo
   pushd $OSSIM_DEPENDENCIES;
   tar xvf $OSSIM_DEV_HOME/qt4-${TYPE}.tgz
   popd
   export BUILD_OSSIM_QT4=ON
   export QT_BINARY_DIR=$OSSIM_DEPENDENCIES/bin
fi

echo "OSSIM_DEPENDENCIES      = $OSSIM_DEPENDENCIES"
if [ -d $OSSIM_DEPENDENCIES ] ; then
   export LD_LIBRARY_PATH=$OSSIM_DEPENDENCIES/lib:$OSSIM_DEPENDENCIES/lib64:$LD_LIBRARY_PATH
   export PATH=$OSSIM_DEPENDENCIES:/bin:$PATH
fi
mkdir -p $OSSIM_BUILD_DIR
rm -f $OSSIM_BUILD_DIR/CMakeCache.txt
export QTDIR=/usr

#export CMAKE_BUILD_TYPE=RelWithDebugInfo
if [ "$CMAKE_BUILD_TYPE" == "" ] ; then
export CMAKE_BUILD_TYPE=Release
fi
export BUILD_OPENCV_PLUGIN=OFF
echo "OSSIM_DEV_HOME        = ${OSSIM_DEV_HOME}"
echo "OSSIM_BUILD_DIR        = ${OSSIM_BUILD_DIR}"
echo "OSSIM_INSTALL_PREFIX        = ${OSSIM_INSTALL_PREFIX}"
$OSSIM_DEV_HOME/ossim/scripts/build.sh
$OSSIM_DEV_HOME/ossim/scripts/install.sh

$OSSIM_DEV_HOME/ossim-oms/joms/build_scripts/linux/build.sh
$OSSIM_DEV_HOME/ossim-oms/joms/build_scripts/linux/install.sh

cp $OSSIM_INSTALL_PREFIX/share/ossim/ossim-preferences-template $OSSIM_INSTALL_PREFIX/share/ossim/ossim-site-preferences
if [ $? -ne 0 ]; then echo "ERROR: Failed build for OSSIM" ; exit 1 ; fi
pushd $OSSIM_DEV_HOME/ossim-$TYPE-all
tar cvfz $ROOT_DIR/ossim-$TYPE-all.tgz *
popd

mkdir -p $OSSIM_DEV_HOME/ossim-$TYPE-dev;
mkdir -p $OSSIM_DEV_HOME/ossim-$TYPE-runtime;
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/include $OSSIM_DEV_HOME/ossim-$TYPE-dev/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/lib $OSSIM_DEV_HOME/ossim-$TYPE-dev/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/lib64 $OSSIM_DEV_HOME/ossim-$TYPE-dev/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/share $OSSIM_DEV_HOME/ossim-$TYPE-dev/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/bin $OSSIM_DEV_HOME/ossim-$TYPE-runtime/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/lib64 $OSSIM_DEV_HOME/ossim-$TYPE-runtime/
cp -R $OSSIM_DEV_HOME/ossim-$TYPE-all/share $OSSIM_DEV_HOME/ossim-$TYPE-runtime/

pushd $OSSIM_DEV_HOME/ossim-$TYPE-dev
tar cvfz $ROOT_DIR/ossim-$TYPE-dev.tgz *
popd

pushd $OSSIM_DEV_HOME/ossim-$TYPE-runtime
tar cvfz $ROOT_DIR/ossim-$TYPE-runtime.tgz *
popd

$OSSIM_DEV_HOME/ossim-oms/joms/build_scripts/linux/build.sh
if [ $? -ne 0 ]; then
   echo; echo "ERROR: Build failed for joms."
   exit 1
fi
$OSSIM_DEV_HOME/ossim-oms/joms/build_scripts/linux/install.sh
if [ $? -ne 0 ]; then
   echo; echo "ERROR: Install failed for joms."
   exit 1
fi

export LD_LIBRARY_PATH=$OSSIM_INSTALL_PREFIX/lib64:$OSSIM_INSTALL_PREFIX/lib:$LD_LIBRARY_PATH

echo "************************** Creating Runtime Sandbox ***************************"
export SANDBOX_NAME=ossim-sandbox-$TYPE-runtime
export SANDBOX_DIR=$OSSIM_DEV_HOME/$SANDBOX_NAME
mkdir -p $SANDBOX_DIR
mkdir -p $SANDBOX_DIR/bin
mkdir -p $SANDBOX_DIR/lib64
mkdir -p $SANDBOX_DIR/lib


# $OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $TEMP_EXTRACT_DIR/lib64 $SANDBOX_DIR
cp -R $OSSIM_INSTALL_PREFIX/lib64/* $SANDBOX_DIR/lib64;
# cp -R $OSSIM_DEPENDENCIES/lib/* $SANDBOX_DIR/lib64/;
# cp -R $OSSIM_DEPENDENCIES/lib64/* $SANDBOX_DIR/lib64/;
cp -R $OSSIM_INSTALL_PREFIX/share $SANDBOX_DIR/;
cp -R $OSSIM_DEPENDENCIES/share $SANDBOX_DIR/;
cp $OSSIM_DEPENDENCIES/bin/gdal* $SANDBOX_DIR/bin/;
cp $OSSIM_DEPENDENCIES/bin/ff* $SANDBOX_DIR/bin/;
cp $OSSIM_DEPENDENCIES/bin/listgeo $SANDBOX_DIR/bin/;
cp -R $OSSIM_INSTALL_PREFIX/bin $SANDBOX_DIR/;
rm -rf $SANDBOX_DIR/bin/ossim-*test
rm -f $SANDBOX_DIR/lib64/*.a

$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim.so $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/liboms.so $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim-wms.so $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim-video.so $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/ossim/plugins $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/bin $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/bin $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/lib $SANDBOX_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/lib64 $SANDBOX_DIR/lib64

if [ -f $OSSIM_INSTALL_PREFIX/lib64/libossimQt.so ]; then
   $OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossimQt.so $SANDBOX_DIR/lib64
fi

chmod +x $SANDBOX_DIR/bin/*
chmod +x $SANDBOX_DIR/lib64/*

pushd $SANDBOX_DIR
tar cvfz $ROOT_DIR/$SANDBOX_NAME.tgz *
popd

pushd $OSSIM_DEV_HOME/ossim-oms/joms

   if "$DEPLOY_JOMS" ; then
      gradle uploadArchives
      if [ $? -ne 0 ]; then
      echo; echo "ERROR: Build failed for JOMS Deploy to Nexus."
      exit 1
      fi
   fi
popd

echo "************************** Creating Runtime Slim Docker ***************************"
export SLIM_NAME=ossim-docker-slim-$TYPE-runtime
export SLIM_DIR=$OSSIM_DEV_HOME/$SLIM_NAME
mkdir -p $SLIM_DIR
mkdir -p $SLIM_DIR/bin
mkdir -p $SLIM_DIR/lib64
mkdir -p $SLIM_DIR/lib


# $OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $TEMP_EXTRACT_DIR/lib64 $SANDBOX_DIR
cp -R $OSSIM_INSTALL_PREFIX/lib64/* $SLIM_DIR/lib64;
# cp -R $OSSIM_DEPENDENCIES/lib/* $SANDBOX_DIR/lib64/;
# cp -R $OSSIM_DEPENDENCIES/lib64/* $SANDBOX_DIR/lib64/;
cp -R $OSSIM_INSTALL_PREFIX/share $SLIM_DIR/;
cp -R $OSSIM_DEPENDENCIES/share $SLIM_DIR/;
cp $OSSIM_DEPENDENCIES/bin/gdal* $SLIM_DIR/bin/;
cp $OSSIM_DEPENDENCIES/bin/ff* $SLIM_DIR/bin/;
cp $OSSIM_DEPENDENCIES/bin/listgeo $SLIM_DIR/bin/;
cp -R $OSSIM_INSTALL_PREFIX/bin $SLIM_DIR/;
rm -rf $SLIM_DIR/bin/ossim-*test
rm -f $SLIM_DIR/lib64/*.a

$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim.so $SLIM_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/liboms.so $SLIM_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim-wms.so $SLIM_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossim-video.so $SLIM_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/ossim/plugins $SLIM_DIR/lib64
$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/bin $SLIM_DIR/lib64
#$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/bin $SLIM_DIR/lib64
#$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/lib $SLIM_DIR/lib64
#$OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_DEPENDENCIES/lib64 $SLIM_DIR/lib64

if [ -f $OSSIM_INSTALL_PREFIX/lib64/libossimQt.so ]; then
   $OSSIM_DEV_HOME/ossim/scripts/ocpld.sh $OSSIM_INSTALL_PREFIX/lib64/libossimQt.so $SLIM_DIR/lib64
fi

chmod +x $SLIM_DIR/bin/*
chmod +x $SLIM_DIR/lib64/*

pushd $SLIM_DIR
tar cvfz $ROOT_DIR/$SLIM_NAME.tgz *
popd

pushd $OSSIM_DEV_HOME/ossim-oms/joms

   if "$DEPLOY_JOMS" ; then
      gradle uploadArchives
      if [ $? -ne 0 ]; then
      echo; echo "ERROR: Build failed for JOMS Deploy to Nexus."
      exit 1
      fi
   fi
popd
exit 0
#

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
#export CMAKE_BUILD_TYPE=Release
#export BUILD_OPENCV_PLUGIN=OFF
#export OSSIM_MAKE_JOBS=12

$OSSIM_DEV_HOME/ossim/scripts/build.sh

# Install it
cd build
make install

/build-scripts/build-joms.sh

for x in `find /usr/local/bin /usr/local/lib /usr/local/lib64 /usr/lib64 \
  /usr/geos38/lib64 /usr/libgeotiff15/lib /usr/gdal30/lib /usr/proj70/lib /usr/ogdi41/lib -type f`; do
  strip $x || true
done

cp -r /usr/lib64 /usr/local
mv /usr/local/lib64/mysql/* /usr/local/lib64

cp -r /usr/geos38/lib64 /usr/local/
cp -r /usr/libgeotiff15/lib /usr/local/
cp -r /usr/gdal30/lib /usr/local/
cp -r /usr/proj70/lib /usr/local/
cp -r /usr/ogdi41/lib /usr/local/

tar -cvz -C /usr/local -f /output/ossim-dist-minimal-centos.tgz .
chmod a+rw /output/ossim-dist-minimal-centos.tgz
