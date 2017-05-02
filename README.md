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

# network debug

        sudo /etc/init.d/networking restart
        systemctl status networking.servie
        cat /etc/network/interfaces.d/wlan0
        sudo cat /etc/wpa_supplicant/wpa_supplicant.conf

# mkisofs deadend

	mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -c newiso-2.0/boot.cat --no-emul-boot --boot-load-size 4 --boot-info-table -J -R -V sidecar newiso-2.0
	mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e images/efiboot.img .
	mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
	dumpet -i ../custom.iso 
	mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
	xorriso -as mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
	grub-mkrescue -o custom.iso newiso-2.0

	dumpet -i ../custom.iso 
	dumpet -i ../ubuntu-16.04.2-server-amd64.iso 

# working fat32 ufi hybrid!

	sudo apt install gdisk
	sudo sgdisk --zap-all /dev/sdc
	sudo sgdisk --new=1:0:0 --typecode=1:ef00 /dev/sdc
	sudo apt install dosfstools
	sudo mkfs.vfat -F32 -n GRUB2EFI /dev/sdc1
	sudo cp -R server-iso/boot new-iso/
	sudo cp -R server-iso/EFI new-iso/
	sudo cp -R mini-iso/* new-iso/
	sudo cp -R ~/initrd-2.0.gz new-iso/

	sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT /dev/sdc
	sudo mount -t vfat /dev/sdc1 new-iso -o uid=1000,gid=1000,umask=022

	cat new-iso/boot/grub/grub.cfg 

	cp ~/sidecar/grub.cfg new-iso/boot/grub/grub.cfg 
