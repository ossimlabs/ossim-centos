FROM centos:7
ENV OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-preferences-template \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java \
    SPRING_CLOUD_CONFIG_ENABLED=false \
    SPRING_CLOUD_DISCOVERY_ENABLED=false 

RUN yum --nogpgcheck -y install epel-release deltarpm \
                https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    # && yum clean all \
    && yum --nogpgcheck -y install gnutls \
                libass libbluray libmodplug lame openjpeg2 librsvg2 soxr speex \
                libtheora libvorbis xz SDL2 java-1.8.0-openjdk-headless \
                libgeotiff15 geos38 gdal30 libjpeg-turbo libjpeg-turbo libcurl haveged && chkconfig haveged on \
    && yum clean all \
    && rm -rf /var/cache/yum

WORKDIR /omar-services
# EXPOSE 8080
#COPY *.jar $HOME/
COPY run-java.sh .
CMD '/bin/bash'
