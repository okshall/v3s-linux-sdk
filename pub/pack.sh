#!/bin/sh
. ./parts.cfg

rm -rf flashimg.bin

dd if=/dev/zero of=flashimg.bin bs=1M count=32
echo "dd uboot to $UBOOT_OFFSET"
dd if=./boot/u-boot-sunxi-with-spl.bin of=flashimg.bin bs=1k seek=$UBOOT_OFFSET conv=notrunc
echo "dd scropt to $SCRIPT_OFFSET"
dd if=./boot/script.bin of=flashimg.bin bs=1k seek=$SCRIPT_OFFSET  conv=notrunc
echo "dd uImage to $UIMAGE_OFFSET"
dd if=./boot/uImage of=flashimg.bin bs=1K seek=$UIMAGE_OFFSET  conv=notrunc
echo "dd rootfs to $ROOTFS_OFFSET"
dd if=rootfs.squashfs of=flashimg.bin  bs=1K seek=$ROOTFS_OFFSET  conv=notrunc
