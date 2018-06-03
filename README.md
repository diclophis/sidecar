# rebake initrd.gz netinst/netboot "mini" iso

https://wiki.ubuntu.com/netinst

        cd /var/tmp
        sh ~/workspace/sidecar/wgets.sh

# inspect original initrd.gz

        cd /var/tmp/
        mkdir initrd
        cd initrd
        gzip -dc /mnt/initrd.gz | cpio -id 

# CPIO archive layering

... #TODO

# add contents of any deb package

        cd /var/tmp/
        mkdir contents-of-linux-image-extra-deb
        dpkg -x /var/tmp/linux-image-extra-4.4.0-62-generic_4.4.0-62.83_amd64.deb contents-of-linux-image-extra-deb
        cd contents-of-linux-image-extra-deb
        find . | cpio --quiet --dereference -o -H newc | gzip -9 > ~/initrd-linux-image-extra.gz

# concat cpio gz archives into single filesystem

        cat /mnt/initrd.gz ~/initrd-linux-image-extra.gz ~/initrd-kickseeds.gz > /mnt/initrd-2.0.gz

# optional (prebake depmod)

        #depmod -b `pwd` 4.4.0-62-generic
        #sudo mount -o loop /var/tmp/ubuntu-16.04.2-desktop-amd64.iso /mnt
        #lzma -dc -S .lz /mnt/casper/initrd.lz | cpio -id
        ... #TODO

# working fat32 ufi hybrid!

        cd /var/tmp

        sudo sgdisk --zap-all /dev/sdc
        sudo sgdisk --new=1:0:0 --typecode=1:ef00 /dev/sdc
        sudo mkfs.vfat -F32 -n GRUB2EFI /dev/sdc1
        sudo mount -t vfat /dev/sdc1 new-iso -o uid=1000,gid=1000,umask=022

# rebake via re-layering from other isos

        cd /var/tmp

        mkdir -p /var/tmp/server-iso && sudo mount -o loop /var/tmp/server.iso server-iso
        sudo cp -R server-iso/boot new-iso/
        sudo cp -R server-iso/EFI new-iso/

        mkdir -p /var/tmp/mini-iso && sudo mount -o loop /var/tmp/mini.iso /var/tmp/mini-iso
        sudo cp -R mini-iso/* new-iso/

# install extra initrds

        cd /var/tmp

        sudo cp -R ~/initrd-2.0.gz new-iso/

# install boot loader

        cd /var/tmp

        cp ~/workspace/sidecar/grub.cfg new-iso/boot/grub/grub.cfg
        sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT /dev/sdc

# details / passwords

        git update-index --skip-worktree rootfs-overlay/etc/wpa_supplicant/wpa_supplicant.conf
        git update-index --skip-worktree rootfs-overlay/home/kangaroo/.ssh/authorized_keys

# transport docker image over ssh

        ssh ubuntu@ops.bardin.haus docker save localhost/webdav:9c4762452af4fee02307b16e9be0defb01d55fc4 | bzip2 | pv | bunzip2 | docker load
