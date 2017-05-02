#!/bin/sh

set -x

if [ ! -e /var/tmp/got-wgets ];
then
  wget http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/hwe-netboot/mini.iso
  wget http://releases.ubuntu.com/xenial/ubuntu-16.04.2-server-amd64.iso
  wget http://security.ubuntu.com/ubuntu/pool/main/l/linux-hwe/linux-image-extra-4.8.0-36-generic_4.8.0-36.36~16.04.1_amd64.deb
  touch /var/tmp/got-wgets
fi
