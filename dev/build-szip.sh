#/bin/sh

OSSIM_DEV_HOME=/work
OSSIM_MAKE_JOBS=8

SZIP="szip-2.1.1"

#
# Setup szip
#
if [ ! -d $OSSIM_DEV_HOME/$SZIP ] ; then
  pushd $OSSIM_DEV_HOME
  wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$SZIP.tgz -O $SZIP.tgz
  tar xvfz $SZIP.tgz
  rm -f $SZIP.tgz
  popd > /dev/null
fi

if [ -d $OSSIM_DEV_HOME/$SZIP ] ; then
   cd $OSSIM_DEV_HOME/$SZIP
   mkdir -p build
   cd build
#   cmake3 -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ..
   cmake3 -DCMAKE_BUILD_TYPE=Release ..
   make -j $OSSIM_MAKE_JOBS install
   if [ $? -ne 0 ]; then echo "szip install error: $error" ; exit 1 ; fi
else
   echo "Error: $OSSIM_DEV_HOME/$SZIP Not found.  Please edit the common.sh to specify the proper version then place the version under https://s3.amazonaws.com/ossimlabs/dependencies/source/"
   exit 1  
fi
