#!/bin/sh

mkdir -p rootfs-empty/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
busybox --install -s rootfs-empty/bin
