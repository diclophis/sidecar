# rebake initrd.gz netinst/netboot "mini" iso

https://wiki.ubuntu.com/netinst

				cd /var/tmp
        wget "http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/hwe-netboot/mini.iso"
				wget "http://security.ubuntu.com/ubuntu/pool/main/l/linux/linux-image-extra-4.4.0-62-generic_4.4.0-62.83_amd64.deb"

# rebake via mkisofs

				sudo mount -o loop /var/tmp/mini.iso /mnt
        ... #TODO

# mount-read/write for easier editing

        sudo apt-get install fuseiso
        cp /var/tmp/mini.iso /var/tmp/mini-read-write-copy.iso
        sudo fuseiso /var/tmp/mini-read-write-copy.iso /mnt
        sudo fusermount -u /mnt

# inspect original initrd.gz

				cd /var/tmp/
				mkdir initrd
        cd initrd
				gzip -dc /mnt/initrd.gz | cpio -id 

# CPIO archive layering

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

# grub config

        cat /mnt/boot/grub/grub.cfg
