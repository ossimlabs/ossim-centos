#!/bin/sh

REPO=registry.iap.maxar.com/gegd/omar
IMAGE=ossim-centos-dist
VERSION=$(grep projectVersion ../gradle.properties | awk -F"=" '{ print $2 }')

docker tag $IMAGE:latest $IMAGE:$VERSION

#docker tag $IMAGE:latest $REPO/$IMAGE:$VERSION
#docker push $REPO/$IMAGE:$VERSION
