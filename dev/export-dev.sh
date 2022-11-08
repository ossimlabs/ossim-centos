#!/bin/sh 

IMAGE=ossim-centos-dev
VERSION=$(grep projectVersion ../gradle.properties | awk -F"=" '{ print $2 }')

docker save $IMAGE:$VERSION | gzip > ${IMAGE}_${VERSION}.tar.gz
