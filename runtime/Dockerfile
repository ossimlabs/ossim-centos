FROM nexus-docker-public-group.ossim.io/centos:7

ENV SPRING_CLOUD_CONFIG_ENABLED=false \
    SPRING_CLOUD_DISCOVERY_ENABLED=false \
    OSSIM_DATA=/data \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-preferences-template \
    LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH \
    PATH=/usr/local/bin:$PATH \
    HOME=/home/omar 

RUN yum --nogpgcheck -y install epel-release deltarpm \
    https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && yum --nogpgcheck -y install gnutls \
        libass libbluray libmodplug lame openjpeg2 librsvg2 soxr speex \
        libtheora libvorbis xz SDL2 java-1.8.0-openjdk-headless \
        libgeotiff15 geos38 gdal30 libjpeg-turbo libjpeg-turbo libcurl haveged \
    && chkconfig haveged on \
    && yum clean all \
    && rm -rf /var/cache/yum

#RUN apk add --update tiff jpeg libpng sqlite-libs libstdc++ curl ffmpeg unzip zip  bash openjdk8 \
#    && rm -rf /var/cache/apk/* \
#    && adduser -D -h $HOME -s /sbin/nologin -u 1001 omar \
#    && chown 1001:0 -R $HOME

ADD ./ossim-dist-minimal-centos.tgz /usr/local
    
EXPOSE 8080

USER 1001
WORKDIR $HOME

COPY run-java.sh run.sh
CMD '/bin/bash'
