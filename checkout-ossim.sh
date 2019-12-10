#!/bin/sh

for x in ossim ossim-plugins ossim-oms ossim-video; do
 git clone https://github.com/ossimlabs/$x.git
done

git clone git@github.com:Maxar-Corp/ossim-private.git
