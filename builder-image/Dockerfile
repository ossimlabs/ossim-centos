#FROM alpine:latest
FROM nexus-docker-public-group.ossim.io/centos:7 as build
ENV OSSIM_DEV_HOME=/work \
    OSSIM_HOME=/work/ossim \
    OSSIM_BUILD_DIR=/work/build \
    OSSIM_VERSION=1.9.0 \
    OSSIM_VERSION_TAG=SNAPSHOT \
    REPOSITORY_MANAGER_URL=https://nexus.ossim.io/repository \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java

RUN yum install -y epel-release deltarpm \
                   https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && yum install -y \
                wget git gcc-c++ cmake make autoconf automake libtool nasm yasm gnutls-devel \
                libass-devel libbluray-devel libmodplug-devel lame-devel openjpeg2-devel librsvg2-devel soxr-devel speex-devel \
                libtheora-devel libvorbis-devel xz-devel SDL2-devel java-1.8.0-openjdk-devel \
                libgeotiff15-devel geos38-devel gdal30-devel libjpeg-turbo-devel libjpeg-turbo-devel libcurl-devel curl cmake3 \
                which unzip zip ant swig3

RUN curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
        yes | sdk install groovy 2.4.17 && \
        yes | sdk install grails 4.0.1 && \
        yes | sdk install gradle 6.0 && \
        yes | sdk install maven 3.6.3 && \
        rm -rf $HOME/.sdkman/archives/* && \
        rm -rf $HOME/.sdkman/tmp/*" \                    
    # && adduser -D -s /bin/bash omar \
    # && chown -R omar:omar /usr/local \
    && rm -rf /var/cache/apk/*

RUN ln -s /root/.sdkman/candidates/gradle/current/bin/gradle /usr/bin/gradle && \
    ln -s /root/.sdkman/candidates/grails/current/bin/grails /usr/bin/grails && \
    ln -s /root/.sdkman/candidates/groovy/current/bin/groovy /usr/bin/groovy && \
    ln -s /root/.sdkman/candidates/maven/current/bin/mvn /usr/bin/mvn

COPY build-scripts /build-scripts
COPY deps /deps
WORKDIR /deps

RUN /build-scripts/build-deps.sh

RUN yes | rm -r /deps/*/.git

# USER omar
# WORKDIR /home/omar
RUN mkdir -p /work

FROM scratch
COPY --from=build / /

ENV OSSIM_DEV_HOME=/work \
    OSSIM_HOME=/work/ossim \
    OSSIM_BUILD_DIR=/work/build \
    OSSIM_VERSION=1.9.0 \
    OSSIM_VERSION_TAG=SNAPSHOT \
    REPOSITORY_MANAGER_URL=https://nexus.ossim.io/repository \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java

WORKDIR /work
CMD /build-scripts/build-ossim.sh
