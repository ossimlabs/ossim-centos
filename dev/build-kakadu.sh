#!/bin/sh

OSSIM_DEV_HOME=/work
KAKADU_VERSION="v7_7_1-01123C"
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64

#
# Setup kakadu
#
if [ ! -d $OSSIM_DEV_HOME/ossim-private ] ; then
  pushd $OSSIM_DEV_HOME
  git clone https://github.com/Maxar-Corp/ossim-private.git
  popd > /dev/null
fi

if [ -d $OSSIM_DEV_HOME/ossim-private ] ; then
   export CXXFLAGS=-fPIC
   cd $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/make
   make -f ./Makefile-Linux-x86-64-gcc
   if [ $? -ne 0 ]; then echo "kakadu build erro: $error" ; exit 1 ; fi
   unset CXXFLAGS
   cd $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/lib
   ln -s Linux-x86-64-gcc/lib* .
   mkdir -p /usr/local/kakadu/managed/all_includes
   mkdir -p /usr/local/kakadu/lib
   mkdir -p /usr/local/kakadu/bin
   mkdir -p /usr/local/kakadu/apps/make
   cp $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/apps/make/*.o /usr/local/kakadu/apps/make
   cp -R $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/managed/all_includes/* /usr/local/kakadu/managed/all_includes
   cp -R $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/lib/Linux-x86-64-gcc/* /usr/local/kakadu/lib/ 
   cp -R $OSSIM_DEV_HOME/ossim-private/kakadu/${KAKADU_VERSION}/bin/Linux-x86-64-gcc/* /usr/local/kakadu/bin/ 
   strip /usr/local/kakadu/lib/libkdu*
   strip /usr/local/kakadu/bin/*
fi
