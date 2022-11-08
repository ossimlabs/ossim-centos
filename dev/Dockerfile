FROM centos:centos7

WORKDIR /work

ENV OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    OSSIM_PREFS_FILE=/data/ossim-preferences-template \
    LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib \
    JAVA_HOME=/usr/lib/jvm/java \
    REPOSITORY_MANAGER_URL=https://repo.osgeo.org/repository/release \
    OSSIM_DEV_HOME=/work \
    OSSIM_HOME=/work/ossim \
    OSSIM_VERSION=1.9.0 \
    OSSIM_VERSION_TAG=SNAPSHOT \
    GROOVY_HOME=/work/groovy-3.0.13 \    
    KAKADU_VERSION=vs8_3-02003C \
    PATH=/usr/gdal34/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# COPY ./build-kakadu.sh ./build-ossim.sh ./build-joms.sh ./apache-groovy-binary-3.0.13.zip /work/
# COPY ./ossim/ /work/ossim/
# COPY ./ossim-oms/ /work/ossim-oms/
# COPY ./ossim-plugins/ /work/ossim-plugins/
# COPY ./ossim-video/ /work/ossim-video/
# COPY ./ossim-private/ /work/ossim-private/

RUN echo "" \
    && useradd --uid 1001 --shell /usr/bin/bash omar \
    && chown -R omar:omar /usr/local \
    && yum install -y epel-release deltarpm \
                   https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && yum localinstall -y  --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm \                   
    && yum install -y \
        wget which git gcc-c++ cmake make java-11-openjdk-devel gdal34-devel \
        gdal34 gdal34-python-tools geos310-devel libgeotiff17-devel  libjpeg-turbo-devel \
        libcurl-devel ffmpeg ffmpeg-devel libpng-devel ant maven automake pcre-devel bison \
    #             autoconf automake libtool nasm yasm gnutls-devel python3 python-pip\
    #             libass-devel libbluray-devel libmodplug-devel lame-devel openjpeg2-devel librsvg2-devel soxr-devel speex-devel \
    #             libtheora-devel libvorbis-devel xz-devel SDL2-devel \
    #             libgeotiff15-devel geos38-devel gdal30-devel libjpeg-turbo-devel libjpeg-turbo-devel libcurl-devel curl cmake3 \
    #             which unzip zip ant swig3 json-c-devel qt-devel.x86_64
    && echo ""

# USER omar
# WORKDIR /home/omar

CMD bash
