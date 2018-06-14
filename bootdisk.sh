#!/bin/sh

#TODO: add dialog and make safety net for formatting disks

set -e
set -x

# working fat32 ufi hybrid!

BOOTDISK_DEV=${1}

sh ~/sidecar/wgets.sh
sh ~/sidecar/apt.sh

mkdir -p tmp
cd tmp

sudo umount ubuntu-16.04.4-server-amd64.iso server-iso || true
sudo umount mini.iso || true

if [ -n "${BOOTDISK_DEV}" ];
then
  sudo umount ${BOOTDISK_DEV}1 || true
  sudo umount ${BOOTDISK_DEV}2 || true
  sudo umount ${BOOTDISK_DEV}3 || true
  sudo sgdisk --zap-all ${BOOTDISK_DEV}
  sudo sgdisk -n 1:2048:4095 -c 1:"BIOS Boot Partition" -t 1:ef02 ${BOOTDISK_DEV}
  sudo sgdisk -n 2:4096:8191 -c 2:"Linux /boot" -t 2:8300 ${BOOTDISK_DEV}
  ENDSECTOR=`sudo sgdisk -E ${BOOTDISK_DEV}`
  sudo sgdisk -n 3:8192:${ENDSECTOR} -c 3:"EFI System Partition" -t 3:ef00 ${BOOTDISK_DEV}
  sudo umount ${BOOTDISK_DEV}1 || true
  sudo umount ${BOOTDISK_DEV}2 || true
  sudo umount ${BOOTDISK_DEV}3 || true
  sudo mkfs.vfat -v -F32 -n GRUB2EFI ${BOOTDISK_DEV}3
  sudo rm -Rf new-iso
  mkdir -p new-iso
  sudo mount -t vfat ${BOOTDISK_DEV}3 new-iso -o uid=1000,gid=1000,umask=022
fi

mkdir -p new-iso-copy

# TODO: cache rebake via re-layering from other isos
mkdir -p extras
for I in linux-image-*
do
  dpkg -x $I extras
done
cd extras
find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../extras.gz
cd ..

mkdir -p kickseeds
cp ../workstation-install.cfg kickseeds
cd kickseeds
find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../kickseeds.gz
cd ..

mkdir -p server-iso && sudo mount -o loop ubuntu-16.04.4-server-amd64.iso server-iso
sudo cp -R server-iso/boot new-iso-copy/
sudo cp -R server-iso/EFI new-iso-copy/

mkdir -p mini-iso && sudo mount -o loop mini.iso mini-iso
sudo cp -R mini-iso/* new-iso-copy/

#NOTE: uudecode required if using binary files! (untar base64 files on the in post)
cd ../rootfs-overlay
shar -T -V . > ../tmp/new-iso-copy/rootfs-overlay.sh
cp ../tmp/new-iso-copy/rootfs-overlay.sh ../tmp/rootfs-overlay.sh
cd ../tmp

rm -Rf rootfs-re-nested
mkdir -p rootfs-re-nested
cp -R ../rootfs-overlay rootfs-re-nested/
cd rootfs-re-nested
find . | cpio --quiet --dereference -o -H newc | gzip -9 > ../rootfs-overlay.gz
cd ..

# install extra initrds
cat mini-iso/initrd.gz extras.gz kickseeds.gz rootfs-overlay.gz > new-iso-copy/initrd-2.0.gz

rm -Rf rootfs-empty
mkdir -p rootfs-empty
cp -R ../rootfs-empty/* rootfs-empty/
cd rootfs-empty
find . | cpio --quiet -o -H newc | gzip -9 > ../rootfs-empty.gz
cd ..

cat rootfs-empty.gz extras.gz > initrd-2.0b.gz

sudo cp ../grub.cfg new-iso-copy/boot/grub/grub.cfg

cp -R new-iso-copy/* new-iso

sync -f new-iso/boot/grub/grub.cfg

if [ -n "${BOOTDISK_DEV}" ];
then
  ## install boot loader
  ##sudo parted ${BOOTDISK_DEV} set 1 bios_grub on
  ##sudo parted ${BOOTDISK_DEV} set 1 boot on
  sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT ${BOOTDISK_DEV} || true

  sudo umount ${BOOTDISK_DEV}1 || true
  sudo umount ${BOOTDISK_DEV}2 || true
  sudo umount ${BOOTDISK_DEV}3 || true
fi;
