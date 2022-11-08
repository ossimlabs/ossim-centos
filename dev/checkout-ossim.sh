#!/bin/sh

mkdir -p work; cd work 

git clone https://github.com/ossimlabs/ossim.git
git clone https://github.com/ossimlabs/ossim-oms.git
git clone https://github.com/ossimlabs/ossim-plugins.git
git clone https://github.com/ossimlabs/ossim-video.git
git clone git@github.com:Maxar-Corp/ossim-private.git
git clone git@github.com:Maxar-Corp/ossim-deepcore.git

wget https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-3.0.13.zip

git clone https://github.com/swig/swig.git; cd swig
git checkout tags/v4.0.2 -b v4.0.2
cd ..
