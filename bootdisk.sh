#!/bin/sh

#TODO: add dialog and make safety net for formatting disks

set -e
set -x

# working fat32 ufi hybrid!

        BOOTDISK_DEV=${1}

        cd /var/tmp

        sudo sgdisk --zap-all ${BOOTDISK_DEV}
        sudo sgdisk --new=1:0:0 --typecode=1:ef00 ${BOOTDISK_DEV}
        sudo umount ${BOOTDISK_DEV}1 || true
        sudo mkfs.vfat -v -F32 -n GRUB2EFI ${BOOTDISK_DEV}1
        sudo mount -t vfat ${BOOTDISK_DEV}1 new-iso -o uid=1000,gid=1000,umask=022

# rebake via re-layering from other isos
        
        sh ~/sidecar/wgets.sh

        sudo umount /var/tmp/server-iso || true
        mkdir -p server-iso && sudo mount -o loop /var/tmp/ubuntu-16.04.2-server-amd64.iso server-iso

        sudo cp -R server-iso/boot new-iso/
        sudo cp -R server-iso/EFI new-iso/

        sudo umount /var/tmp/mini-iso || true
        mkdir -p /var/tmp/mini-iso && sudo mount -o loop /var/tmp/mini.iso /var/tmp/mini-iso
        sudo cp -R mini-iso/* new-iso/

        mkdir -p extras

        cp ~/sidecar/workstation-install.cfg extras
        dpkg -x /var/tmp/linux-image-extra-4.8.0-36-generic_4.8.0-36.36~16.04.1_amd64.deb extras

        cd extras
        find . | cpio --quiet --dereference -o -H newc | gzip -9 > ~/extras.gz

# install extra initrds

        cd /var/tmp

        cat /var/tmp/mini-iso/initrd.gz ~/extras.gz > /var/tmp/new-iso/initrd-2.0.gz

# install boot loader

        cp ~/sidecar/grub.cfg new-iso/boot/grub/grub.cfg
        sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT ${BOOTDISK_DEV}

        #TODO: figure out bootstrap rootfs better

        sudo umount ${BOOTDISK_DEV}1
