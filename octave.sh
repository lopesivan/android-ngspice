#!/system/bin/sh

 PROOT=/data/data/com.octave/app_install/support/proot
ROOTFS=/data/data/com.octave/app_install/rootfs
   BIN=/usr/bin/octave

$PROOT -r $ROOTFS -b /res -b data $BIN

echo bye

exit 0
