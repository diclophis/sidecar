#!/bin/sh

set -x
set -e

FAKE_DISK=disk.raw

dd if=/dev/zero of=${FAKE_DISK} bs=1024k seek=4096 count=0
#sgdisk --zap-all ${FAKE_DISK}
#sgdisk --new=1:0:0 --typecode=1:ef00 ${FAKE_DISK}
