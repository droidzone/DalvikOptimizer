#!/sbin/sh
#Step 1
# FLUSH DALVIK CACHE AND REBUILD SYSTEM DEXES - RECOMMENDED AFTER TITANIUM RESTORE
TMPDIR=/tmp/backup
MOUNTPT='/system/xbin/busybox mount -t ext4 -o barrier=0,noatime,nodiratime,nosuid,nodev,nobh,nouser_xattr,noauto_da_alloc,commit=50 /dev/block/mmcblk0p2 /data'
mount /system
$MOUNTPT
mkdir $TMPDIR
cp -a /data/dalvik-cache/system@framework@core.jar* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@bouncy* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@ext.* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@frame* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@android.pol* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@services* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@core-* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.htc.comm* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.htc.fram* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.htc.android.pi* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.htc.android.eas* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.scalado.util.* $TMPDIR/
cp -a /data/dalvik-cache/system@framework@com.orange.authentication.* $TMPDIR/
cd $TMPDIR
sync
cd /data/dalvik-cache/
rm -rf *
cd $TMPDIR
cp -a * /data/dalvik-cache/
cd /data/dalvik-cache/
sync
cd /
#Step2 Flush Cache
TMPDIR=/tmp/log
mkdir $TMPDIR
cp -a /cache/log/* $TMPDIR
sync
cd /cache/log
rm -rf *
cd /
cp -a $TMPDIR/* /cache/log
sync
umount /data
umount /system
#System will now remount
#reboot    #Maybe makes some people disconcerted. :)
