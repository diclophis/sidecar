#!/bin/sh

set -x
set -e

mkdir -p tmp

if [ ! -e tmp/got-wgets ];
then
  cd tmp
  wget http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/hwe-netboot/mini.iso
  wget http://releases.ubuntu.com/xenial/ubuntu-16.04.4-server-amd64.iso
  wget http://security.ubuntu.com/ubuntu/pool/main/l/linux-hwe/linux-image-extra-4.13.0-36-generic_4.13.0-36.40~16.04.1_amd64.deb
  touch got-wgets
fi
