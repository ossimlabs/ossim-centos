#!/bin/sh

OSSIM_DEV_HOME=/work
OSSIM_MAKE_JOBS=8

FFMPEG=ffmpeg-4.2

#
# Setup FFMPEG
#
if [ ! -d $OSSIM_DEV_HOME/$FFMPEG ] ; then
  pushd $OSSIM_DEV_HOME
  wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$FFMPEG.tgz -O $FFMPEG.tgz
  tar xvfz $FFMPEG.tgz
  rm -f $FFMPEG.tgz
fi

if [ -d $OSSIM_DEV_HOME/$FFMPEG ] ; then
   cd $OSSIM_DEV_HOME/$FFMPEG
   ./configure --prefix=/usr/local \
               --enable-swscale --enable-avfilter --enable-avresample \
               --enable-libmp3lame --enable-libvorbis \
               --enable-librsvg --enable-libtheora --enable-libopenjpeg \
               --enable-libmodplug --enable-libsoxr \
               --enable-libspeex --enable-libass --enable-libbluray \
               --enable-lzma --enable-gnutls --enable-fontconfig --enable-libfreetype \
               --enable-libfribidi --disable-libjack --disable-libopencore-amrnb \
               --disable-libopencore-amrwb --disable-libxcb --disable-libxcb-shm --disable-libxcb-xfixes \
               --disable-indev=jack --disable-outdev=xv\
               --enable-sdl2 --disable-securetransport --mandir=/usr/local/share/man \
               --enable-shared --enable-pthreads --arch=x86_64 --enable-x86asm \
               --enable-gpl --enable-postproc --enable-libx264 
   make -j $OSSIM_MAKE_JOBS install
   strip `find /usr/local/lib -type f`
   strip /usr/local/bin/*
   if [ $? -ne 0 ]; then echo "ffmpeg make install error: $error" ; exit 1 ; fi

else
   echo "Error: $OSSIM_DEV_HOME/$FFMPEG Not found.  Please edit the common.sh to specify the proper version then place the version under https://s3.amazonaws.com/ossimlabs/dependencies/source/"
fi
