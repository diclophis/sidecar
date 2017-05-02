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

    1  ls
    2  ps aufx
    3  htop
    4  sudo apt-get install htop
    5  ifconfuig
    6  ifconfig
    7  sudo /etc/init.d/networking restart
    8  sudo vi /etc/network/interfaces
    9  sudo vi /etc/network/interfaces.d/wlan0
   10  sudo /etc/init.d/networking restart
   11  systemctl status networking.servie
   12  systemctl status networking.service
   13  sudo vi /etc/network/interfaces.d/wlan0
   14  systemctl status networking.service
   15  sudo /etc/init.d/networking restart
   16  systemctl status networking.service
   17  ifquery --read-environment --list
   18  sudo vi /etc/network/interfaces.d/wlan0
   19  systemctl status networking.service
   20  sudo /etc/init.d/networking restart
   21  systemctl status networking.service
   22  ifquery --read-environment --list
   23  sudo vi /etc/network/interfaces.d/wlan0
   24  sudo /etc/init.d/networking restart
   25  systemctl status networking.service
   26  systemctl restart networking.service
   27  systemctl restart networking
   28  restart networking.service
   29  systemctl restart networking
   30  systemctl status networking.service
   31  sudo lsmod | grep iwl
   32  sudo modprobe iwlmvm
   33  systemctl restart networking
   34  sudo /etc/init.d/networking restart
   35  systemctl status networking.service
   36  dmesg 
   37  ifquery --read-environment --list
   38  sudo mv /etc/network/interfaces.d/wlan0 /etc/network/interfaces.d/w1p1s0
   39  sudo /etc/init.d/networking restart
   40  journalctl -xe
   41  dmesg | grep wifi
   42  dmesg | grep -i wifi
   43  dmesg | grep -i intel
   44  dmesg | grep -i amt
   45  dmesg | grep -i vpro
   46  dmesg | grep -i duo
   47  dmesg | grep -i core
   48  dmesg | grep -i wlan
   49  sudo vi /etc/network/interfaces.d/w1p1s0 
   50  sudo /etc/init.d/networking restart
   51  sudo apt-get install htop
   52  htop
   53  ls
   54  sudo vi /etc/network/interfaces.d/w1p1s0 
   55  apt search network manager
   56  apt search network manager | grep NetworkMana
   57  apt search network manager less
   58  apt search network manager | less
   59  sudo apt-get install network-manager
   60  sudo vi /etc/network/interfaces.d/w1p1s0 
   61  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
   62  sudo /etc/init.d/networking restart
   63  ifconfig
   64  sudo /etc/init.d/networking stop
   65  sudo /etc/init.d/networking start
   66  ifconfig
   67  sudo vi /etc/network/interfaces.d/w1p1s0 
   68  sudo /etc/init.d/networking restart
   69  systemctl status networking.service
   70  sudo vi /etc/network/interfaces.d/w1p1s0 
   71  sudo /etc/init.d/networking restart
   72  ifconfig
   73  dmesg 
   74  systemctl status networking.service
   75  ifup w1l2s0b1
   76  sudo vi /etc/network/interfaces.d/w1p1s0 
   77  ifup wlp2s0b1
   78  sudo ifup wlp2s0b1
   79  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
   80  sudo vi /etc/network/interfaces.d/w1p1s0 
   81  sudo /etc/init.d/networking restart
   82  ifconfig
   83  systemctl status networking.service
   84  ls -ltr /var/log/
   85  cat /var/log/syslog 
   86  sudo vi /etc/network/interfaces.d/w1p1s0 
   87  sudo /etc/init.d/networking restart
   88  systemctl status networking.service
   89  sudo vi /etc/network/interfaces.d/w1p1s0 
   90  sudo /etc/init.d/networking restart
   91  ifconfig
   92  ping google.com
   93  ping 8.8.8.8
   94  ifconfig
   95  dm
   96  dmesg 
   97  systemctl status networking.service
   98  ifconfig
   99  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  100  sudo /etc/init.d/networking restart
  101  ifconfig
  102  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  103  sudo vi /etc/network/interfaces.d/w1p1s0 
  104  sudo /etc/init.d/networking restart
  105  ifconfig
  106  sudo ifdown wlp2s0b1
  107  ifconfig
  108  ip addr
  109  ifconfig
  110  sudo vi /etc/network/interfaces.d/w1p1s0 
  111  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  112  sudo /etc/init.d/networking restart
  113  ifconfig
  114  sudo /etc/init.d/networking stop
  115  ifconfig
  116  sudo reboot
  117  ifconfig
  118  sudo /etc/init.d/networking restart
  119  ifconfig
  120  systemctl status networking.service
  121  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  122  sudo /etc/init.d/networking restart
  123  ifconfig
  124  sudo vi /etc/network/interfaces.d/w1p1s0 
  125  sudo /etc/init.d/networking restart
  126  ifconfig
  127  sudo vi /etc/network/interfaces.d/w1p1s0 
  128  cat /etc/wpa_supplicant/wpa_supplicant.conf 
  129  sudo vi /etc/network/interfaces.d/w1p1s0 
  130  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  131  sudo /etc/init.d/networking restart
  132  ifconfig
  133  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  134  sudo /etc/init.d/networking restart
  135  ifconfig
  136  cat /var/log/syslog 
  137  ifconfig
  138  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  139  sudo vi /etc/network/interfaces.d/w1p1s0 
  140  dmesg | grep wlp
  141  sudo vi /etc/network/interfaces.d/w1p1s0 
  142  sudo /etc/init.d/networking restart
  143  ifconfig
  144  ifup wlp2s0b1
  145  sudo ifup wlp2s0b1
  146  ifconfig
  147  sudo reboot
  148  ls
  149  ifconfig
  150  sudo vi /etc/network/interfaces.d/w1p1s0 
  151  sudo /etc/init.d/networking restart
  152  ifconfig
  153  ls
  154  dmesg 
  155  ssh-keygen 
  156  cat ~/.ssh/id_rsa.pub | nc 192.168.1.2 12345
  157  git
  158  sudo apt install git-core
  159  ssh-add
  160  git clone git@github.com:mavenlink/sidecar.git
  161  cd sidecar/
  162  ls
  163  cat /etc/network/interfaces.d/w1p1s0 
  164  cat /etc/network/interfaces.d/w1p1s0 | tee wlan0
  165  cp /etc/wpa_supplicant/wpa_supplicant.conf .
  166  ls
  167  vi wpa_supplicant.conf 
  168  cd
  169  cd /var/tmp/
  170  vi ~/sidecar/README.md 
  171  cat ~/sidecar/README.md 
  172  cat ~/sidecar/README.md | grep wget
  173  cat ~/sidecar/README.md | grep wget | xargs
  174  cat ~/sidecar/README.md | grep wget | xargs -n1
  175  cat ~/sidecar/README.md | grep wget | xargs -n2
  176  cat ~/sidecar/README.md | grep wget | xargs -n2 > wgets.sh
  177  vi wgets.sh 
  178  sh wgets.sh 
  179  vi ~/sidecar/README.md 
  180  sudo apt-get install fuseiso
  181  vi ~/sidecar/README.md 
  182  sudo mount /var/tmp/mini.iso /mnt
  183  sudo umount /mnt
  184  sudo fuseio /var/tmp/mini.iso /mnt
  185  sudo fuseiso /var/tmp/mini.iso /mnt
  186  mkdir extras
  187  ls
  188  dpkg -x linux-image-extra-4.4.0-62-generic_4.4.0-62.83_amd64.deb extras/
  189  cd extras/
  190  find . | cpio --quiet --dereference -o -H newc | gzip -9 > ~/extras.gz
  191  cp ~/sidecar/workstation-install.cfg .
  192  vi workstation-install.cfg 
  193  find . | cpio --quiet --dereference -o -H newc | gzip -9 > ~/extras.gz
  194  vi ~/sidecar/README.md 
  195  ls -l /mnt
  196  sudo ls -l /mnt
  197  sudo cat /mnt/initrd.gz ~/extras.gz /mnt/initrd-2.0.gz
  198  sudo cat /mnt/initrd.gz ~/extras.gz > /mnt/initrd-2.0.gz
  199  sudo cat /mnt/initrd.gz ~/extras.gz | tee /mnt/initrd-2.0.gz > /dev/null
  200  sudo touch /mnt/wtf
  201  sudo apt install cdrtools
  202  sudo apt install mkisofs
  203  man mkisofs
  204  mkisofs -h
  205  sudo cat /mnt/initrd.gz ~/extras.gz > ~/initrd-2.0.gz
  206  cd ..
  207  mkdir newiso
  208  sudo fusermount -u /mnt
  209  sudo fuseiso /var/tmp/mini.iso /var/tmp/fart
  210  mkdir fart
  211  fuseiso /var/tmp/mini.iso /var/tmp/fart
  212  cp -R fart newiso-2.0
  213  ls -l newiso-2.0/
  214  cp ~/initrd-2.0.gz newiso-2.0/
  215  sudo chmod u+w newiso-2.0/
  216  cp ~/initrd-2.0.gz newiso-2.0/
  217  mkisofs -h
  218  mkisofs -o ~/custom.iso newiso-2.0
  219  ls -l ~/custom.iso 
  220  ls -h ~/*.iso
  221  ls -l *iso
  222  mkisofs -o custom.iso newiso-2.0
  223  ls -lh *iso 
  224  ls -lh *.iso 
  225  find /usr -name "*.bin"
  226  mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -c newiso-2.0/boot.cat --no-emul-boot --boot-load-size 4 --boot-info-table -J -R -V sidecar newiso-2.0
  227  mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -c newiso-2.0/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V sidecar newiso-2.0
  228  mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -c newiso-2.0/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R newiso-2.0
  229  mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -c newiso-2.0/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table newiso-2.0
  230  mkisofs -o custom.iso -b newiso-2.0/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table newiso-2.0
  231  cd newiso-2.0/
  232  mkisofs -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
  233  mkisofs -o ../custom.iso -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
  234  mkisofs -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
  235  chmod u+w isolinux.bin 
  236  mkisofs -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
  237  mkisofs -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot .
  238  ls 
  239  ls boot
  240  ls boot/grub/
  241  ls boot/grub/x86_64-efi/
  242  apt search dumpet
  243  sudo apt install dumpet
  244  dumpet -i ../custom.iso 
  245  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e images/efiboot.img .
  246  mkdir isolinux
  247  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e images/efiboot.img .
  248  mv isolinux.bin isolinux/
  249  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e images/efiboot.img .
  250  find /usr -name "*.img"
  251  find . -name "*.img"
  252  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e boot/grub/efi.img .
  253  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4864 -boot-info-table -R -J -T -eltorito-alt-boot -e boot/grub/efi.img .
  254  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4865 -boot-info-table -R -J -T -eltorito-alt-boot -e boot/grub/efi.img .
  255  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e boot/grub/efi.img .
  256  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -e boot/grub/efi.img -input-charset utf-8 .
  257  mkisofs -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -T -eltorito-alt-boot -input-charset utf-8 .
  258  dumpet -i ../custom.iso 
  259  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -joilet-long -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  260  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  261  dumpet -i ../custom.iso 
  262  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  263  ls
  264  cd ..
  265  rm -rf newiso*
  266  sudo rm -rf newiso*
  267  cp -R fart newiso-2.0
  268  cp ~/initrd-2.0.gz newiso-2.0/
  269  sudo rm -rf newiso*
  270  cp -rT ~/initrd-2.0.gz newiso-2.0/
  271  cp -T ~/initrd-2.0.gz newiso-2.0/
  272  cp -rT fart newiso-2.0
  273  cp ~/initrd-2.0.gz newiso-2.0/
  274  sudo fusermount -u fart
  275  sudo mount /var/tmp/mini.iso /mnt
  276  cp -rT /mnt newiso-2.0
  277  rm -Rf newiso-2.0
  278  sudo rm -Rf newiso-2.0
  279  cp -rT /mnt newiso-2.0
  280  cp ~/initrd-2.0.gz newiso-2.0/
  281  sudo chmod u+w newiso-2.0/
  282  cp ~/initrd-2.0.gz newiso-2.0/
  283  cd newiso-2.0/
  284  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  285  chmod u+w isolinux.bin 
  286  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  287  dumpet -i ../custom.iso 
  288  ls -l boot/grub/efi.img 
  289  find . -name "*.img"
  290  mount
  291  cd ..
  292  vi wgets.sh 
  293  sh wgets.sh 
  294  vi wgets.sh 
  295  sh wgets.sh 
  296  vi wgets.sh 
  297  sh wgets.sh 
  298  sudo mkdir /var/tmp/server-iso
  299  sudo mount -o loop /var/tmp/ubuntu-16.04.2-server-amd64.iso /var/tmp/server-iso
  300  cp -rT /var/tmp/server-iso newiso-2.0
  301  sudo rm -Rf newiso-2.0
  302  cp -rT /var/tmp/server-iso newiso-2.0
  303  sudo chmod u+w newiso-2.0/
  304  ls
  305  cd newiso-2.0/
  306  ls
  307  cp ~/initrd-2.0.gz .
  308  ls
  309  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  310  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  311  chmod u+w isolinux/isolinux.bin 
  312  mkisofs -o ../custom.iso -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  313  dumpet -i ../custom.iso 
  314  mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" .
  315  dumpet -i ../custom.iso 
  316  mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -joliet-long .
  317  dumpet -i ../custom.iso 
  318  mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -joliet-long -T .
  319  dumpet -i ../custom.iso 
  320  rm ../custom.iso 
  321  dumpet -i ../custom.iso 
  322  mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -joliet-long -T .
  323  dumpet -i ../custom.iso 
  324  dumpet -i ../ubuntu-16.04.2-server-amd64.iso 
  325  dumpet -i ../custom.iso 
  326  sudo mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -joliet-long -T .
  327  dumpet -i ../custom.iso 
  328  mkisofs -o ../custom.iso -U -e boot/grub/efi.img -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -v -J -T -eltorito-alt-boot -input-charset utf-8 -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -joliet-long -T .
  329  rm ../custom.iso 
  330  mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  331  dumpet -i ../custom.iso 
  332  cd ..
  333  sudo rm -Rf newiso-2.0
  334  cp -rT /mnt newiso-2.0
  335  sudo chmod u+w newiso-2.0/
  336  cd newiso-2.0/
  337  cp ~/initrd-2.0.gz .
  338  chmod u+w isolinux.bin
  339  rm ../custom.iso 
  340  mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  341  dumpet -i ../custom.iso 
  342  cd ..
  343  cd newiso-2.0/
  344  xorrisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  345  dumpet -i ../custom.iso 
  346  ls -lh ../custom.iso 
  347  rm ../custom.iso 
  348  ls -lh ../custom.iso 
  349  xorrisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  350  xorrisofs -as mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  351  clear
  352  xorrisofs -as mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  353  xorriso
  354  xorriso -help
  355  xorriso -help | grep mkisofs
  356  xorriso -as mkisofs -U -A "Custom1604" -V "Custom1604" -volset "Custom1604" -J -joliet-long -r -v -T -o ../custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
  357  dumpet -i ../custom.iso 
  358  dumpet -i ../ubuntu-16.04.2-server-amd64.iso 
  359  history >> ~/sidecar/README.md 
    1  ls
    2  ps aufx
    3  htop
    4  sudo apt-get install htop
    5  ifconfuig
    6  ifconfig
    7  sudo /etc/init.d/networking restart
    8  sudo vi /etc/network/interfaces
    9  sudo vi /etc/network/interfaces.d/wlan0
   10  sudo /etc/init.d/networking restart
   11  systemctl status networking.servie
   12  systemctl status networking.service
   13  sudo vi /etc/network/interfaces.d/wlan0
   14  systemctl status networking.service
   15  sudo /etc/init.d/networking restart
   16  systemctl status networking.service
   17  ifquery --read-environment --list
   18  sudo vi /etc/network/interfaces.d/wlan0
   19  systemctl status networking.service
   20  sudo /etc/init.d/networking restart
   21  systemctl status networking.service
   22  ifquery --read-environment --list
   23  sudo vi /etc/network/interfaces.d/wlan0
   24  sudo /etc/init.d/networking restart
   25  systemctl status networking.service
   26  systemctl restart networking.service
   27  systemctl restart networking
   28  restart networking.service
   29  systemctl restart networking
   30  systemctl status networking.service
   31  sudo lsmod | grep iwl
   32  sudo modprobe iwlmvm
   33  systemctl restart networking
   34  sudo /etc/init.d/networking restart
   35  systemctl status networking.service
   36  dmesg 
   37  ifquery --read-environment --list
   38  sudo mv /etc/network/interfaces.d/wlan0 /etc/network/interfaces.d/w1p1s0
   39  sudo /etc/init.d/networking restart
   40  journalctl -xe
   41  dmesg | grep wifi
   42  dmesg | grep -i wifi
   43  dmesg | grep -i intel
   44  dmesg | grep -i amt
   45  dmesg | grep -i vpro
   46  dmesg | grep -i duo
   47  dmesg | grep -i core
   48  dmesg | grep -i wlan
   49  sudo vi /etc/network/interfaces.d/w1p1s0 
   50  sudo /etc/init.d/networking restart
   51  sudo apt-get install htop
   52  htop
   53  ls
   54  sudo vi /etc/network/interfaces.d/w1p1s0 
   55  apt search network manager
   56  apt search network manager | grep NetworkMana
   57  apt search network manager less
   58  apt search network manager | less
   59  sudo apt-get install network-manager
   60  sudo vi /etc/network/interfaces.d/w1p1s0 
   61  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
   62  sudo /etc/init.d/networking restart
   63  ifconfig
   64  sudo /etc/init.d/networking stop
   65  sudo /etc/init.d/networking start
   66  ifconfig
   67  sudo vi /etc/network/interfaces.d/w1p1s0 
   68  sudo /etc/init.d/networking restart
   69  systemctl status networking.service
   70  sudo vi /etc/network/interfaces.d/w1p1s0 
   71  sudo /etc/init.d/networking restart
   72  ifconfig
   73  dmesg 
   74  systemctl status networking.service
   75  ifup w1l2s0b1
   76  sudo vi /etc/network/interfaces.d/w1p1s0 
   77  ifup wlp2s0b1
   78  sudo ifup wlp2s0b1
   79  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
   80  sudo vi /etc/network/interfaces.d/w1p1s0 
   81  sudo /etc/init.d/networking restart
   82  ifconfig
   83  systemctl status networking.service
   84  ls -ltr /var/log/
   85  cat /var/log/syslog 
   86  sudo vi /etc/network/interfaces.d/w1p1s0 
   87  sudo /etc/init.d/networking restart
   88  systemctl status networking.service
   89  sudo vi /etc/network/interfaces.d/w1p1s0 
   90  sudo /etc/init.d/networking restart
   91  ifconfig
   92  ping google.com
   93  ping 8.8.8.8
   94  ifconfig
   95  dm
   96  dmesg 
   97  systemctl status networking.service
   98  ifconfig
   99  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  100  sudo /etc/init.d/networking restart
  101  ifconfig
  102  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  103  sudo vi /etc/network/interfaces.d/w1p1s0 
  104  sudo /etc/init.d/networking restart
  105  ifconfig
  106  sudo ifdown wlp2s0b1
  107  ifconfig
  108  ip addr
  109  ifconfig
  110  sudo vi /etc/network/interfaces.d/w1p1s0 
  111  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  112  sudo /etc/init.d/networking restart
  113  ifconfig
  114  sudo /etc/init.d/networking stop
  115  ifconfig
  116  sudo reboot
  117  ifconfig
  118  sudo /etc/init.d/networking restart
  119  ifconfig
  120  systemctl status networking.service
  121  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  122  sudo /etc/init.d/networking restart
  123  ifconfig
  124  sudo vi /etc/network/interfaces.d/w1p1s0 
  125  sudo /etc/init.d/networking restart
  126  ifconfig
  127  sudo vi /etc/network/interfaces.d/w1p1s0 
  128  cat /etc/wpa_supplicant/wpa_supplicant.conf 
  129  sudo vi /etc/network/interfaces.d/w1p1s0 
  130  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  131  sudo /etc/init.d/networking restart
  132  ifconfig
  133  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  134  sudo /etc/init.d/networking restart
  135  ifconfig
  136  cat /var/log/syslog 
  137  ifconfig
  138  sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
  139  sudo vi /etc/network/interfaces.d/w1p1s0 
  140  dmesg | grep wlp
  141  sudo vi /etc/network/interfaces.d/w1p1s0 
  142  sudo /etc/init.d/networking restart
  143  ifconfig
  144  ifup wlp2s0b1
  145  sudo ifup wlp2s0b1
  146  ifconfig
  147  sudo reboot
  148  cd sidecar/
  149  git status
  150  vi wlan0 
  151  vi wpa_supplicant.conf 
  152  git status
  153  git add .
  154  git status
  155  git commit -m "add wifi config"
  156  git config --global user.email "diclophis@gmail.com"
  157  git config --global user.name "Jon Bardin"
  158  git commit --amend --reset-author
  159  git push -u origin master
  160  git pull
  161  vi README.md 
  162  git status
  163  git add README.md 
  164  git commit
  165  git push -u origin master
  166  vi README.md 
  167  cd /var/tmp/
  168  ls
  169  grub-mkrescue -o custom.iso newiso-2.0
  170  ls -lh *iso
  171  sudo dd if=custom.iso of=/dev/sdc bs=10M
  172  dumpet -i custom.iso 
  173  grub-mkrescue -h
  174  grub-mkrescue --help
  175  cd newiso-2.0/
  176  grep xor ~/sidecar/README.md 
  177  sudo apt install gdisk
  178  sudo sgdisk --zap-all /dev/sdc
  179  echo $?
  180  sudo sgdisk --new=1:0:0 --typecode=1:ef00 /dev/sdc
  181  apt search mkfs.vfat
  182  apt search mkfs.fast
  183  apt search mkfs.fat
  184  sudo apt install dosfstools
  185  sudo mkfs.vfat -F32 -n GRUB2EFI /dev/sdc1
  186  cd ..
  187  mkdir new-iso
  188  sudo mount /dev/sdc1 new-iso
  189  sudo umount new-iso
  190  sudo mount -t vfat /dev/sdc1 new-iso -o uid=1000,gid=1000,umask=022
  191  ls -l /mnt/
  192  sudo mount -o loop ubuntu-16.04.2-server-amd64.iso /var/tmp/server-iso
  193  mkdir mini-iso
  194  sudo mount -o loop mini.iso /var/tmp/mini-iso
  195  cp -R server-iso/* new-iso/
  196  sudo cp -R server-iso/* new-iso/
  197  rm -Rf new-iso
  198  rm -Rf new-iso/*
  199  ls -l new-iso/
  200  df -h
  201  rm -Rf new-iso/{pool,preseed}
  202  rm -Rf new-iso/README.diskdefines 
  203  ls -l new-iso/
  204  sudo cp -R server-iso/boot new-iso/
  205  sudo cp -R server-iso/EFI new-iso/
  206  sudo cp -R mini-iso/* new-iso/
  207  sudo cp -R ~/initrd-2.0.gz new-iso/
  208  sudo grub-install --removable --boot-directory=new-iso/boot --efi-directory=new-iso/EFI/BOOT /dev/sdc
  209  echo $?
  210  sudo umount new-iso
  211  sudo mount -t vfat /dev/sdc1 new-iso -o uid=1000,gid=1000,umask=022
  212  vi new-iso/boot/grub/grub.cfg 
  213  cp ~/sidecar/grub.cfg new-iso/boot/grub/grub.cfg 
  214  vi new-iso/boot/grub/grub.cfg 
  215  sudo umount new-iso
  216  rm -Rf extras/usr
  217  rm -Rf extras/lib
  218  history >> ~/sidecar/README.md 
