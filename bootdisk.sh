#!/bin/sh

#TODO: add dialog and make safety net for formatting disks

set -e
set -x

# working fat32 ufi hybrid!

BOOTDISK_DEV=${1}

if [ -z "${BOOTDISK_DEV}" ];
then
  echo bad BOOTDISK_DEV arg
  exit 1
fi

sh ~/sidecar/wgets.sh
sh ~/sidecar/apt.sh

mkdir -p tmp
cd tmp

sudo umount ubuntu-16.04.4-server-amd64.iso server-iso || true
sudo umount mini.iso || true

sudo umount ${BOOTDISK_DEV}1 || true
sudo sgdisk --zap-all ${BOOTDISK_DEV}
sudo sgdisk --new=1:0:0 --typecode=1:ef00 ${BOOTDISK_DEV}
sudo umount ${BOOTDISK_DEV}1 || true
sudo mkfs.vfat -v -F32 -n GRUB2EFI ${BOOTDISK_DEV}1

sudo rm -Rf new-iso
mkdir -p new-iso

sudo mount -t vfat ${BOOTDISK_DEV}1 new-iso -o uid=1000,gid=1000,umask=022

# rebake via re-layering from other isos
        
#mkdir -p extras
#dpkg -x linux-image-extra-4.13.0* extras
#cd extras
#find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../extras.gz
#cd ..

mkdir -p kickseeds
cp ../workstation-install.cfg kickseeds
cd kickseeds
find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../kickseeds.gz
cd ..

mkdir -p server-iso && sudo mount -o loop ubuntu-16.04.4-server-amd64.iso server-iso
sudo cp -R server-iso/boot new-iso/
sudo cp -R server-iso/EFI new-iso/

mkdir -p mini-iso && sudo mount -o loop mini.iso mini-iso
sudo cp -R mini-iso/* new-iso/

#NOTE: uudecode required if using binary files... (untar base64 files on the in post)
cd ../rootfs-overlay
#TODO: do not overlap with boot installer
shar -T -V . > ../tmp/new-iso/rootfs-overlay.sh
cp ../tmp/new-iso/rootfs-overlay.sh ../tmp/rootfs-overlay.sh
cd ../tmp

rm -Rf rootfs-re-nested
mkdir -p rootfs-re-nested
cp -R ../rootfs-overlay rootfs-re-nested/
cd rootfs-re-nested
find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../rootfs-overlay.gz
cd ..

# install extra initrds
#cat mini-iso/initrd.gz extras.gz ~/kickseeds.gz > /var/tmp/new-iso/initrd-2.0.gz
cat mini-iso/initrd.gz extras.gz kickseeds.gz rootfs-overlay.gz > new-iso/initrd-2.0.gz

# install boot loader

#TODO: figure out bootstrap rootfs better
sudo cp ../grub.cfg new-iso/boot/grub/grub.cfg

sync -f new-iso/boot/grub/grub.cfg

#sudo parted ${BOOTDISK_DEV} set 1 bios_grub on
sudo parted ${BOOTDISK_DEV} set 1 boot on
sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT ${BOOTDISK_DEV} || true

sudo umount ${BOOTDISK_DEV}1
