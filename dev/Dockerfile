FROM centos:7
ENV OSSIM_DEV_HOME=/work \
    OSSIM_HOME=/work/ossim \
    OSSIM_BUILD_DIR=/work/build \
    OSSIM_VERSION=1.9.0 \
    OSSIM_VERSION_TAG=SNAPSHOT \
    REPOSITORY_MANAGER_URL=https://nexus.ossim.io/repository/all-repos \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java
RUN yum --nogpgcheck -y install epel-release deltarpm \
                https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    # && yum clean all \
    && yum --nogpgcheck -y install \
                wget git gcc-c++ cmake make autoconf automake libtool nasm yasm gnutls-devel \
                libass-devel libbluray-devel libmodplug-devel lame-devel openjpeg2-devel librsvg2-devel soxr-devel speex-devel \
                libtheora-devel libvorbis-devel xz-devel SDL2-devel java-1.8.0-openjdk-devel \
                libgeotiff15-devel geos38-devel gdal30-devel libjpeg-turbo-devel libjpeg-turbo-devel libcurl-devel curl cmake3 \
                which unzip zip ant swig3 \
    && curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
        yes | sdk install groovy $GROOVY_VERSION && \
        yes | sdk install grails $GRAILS_VERSION && \
        yes | sdk install gradle $GRADLE_VERSION && \
        yes | sdk install maven $MAVEN_VERSION && \
        rm -rf $HOME/.sdkman/archives/* && \
        rm -rf $HOME/.sdkman/tmp/*" \                    
    && yum clean all \
    && rm -rf /var/cache/yum
WORKDIR /work
