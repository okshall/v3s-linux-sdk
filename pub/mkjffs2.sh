#!/bin/sh
. ./parts.cfg
#../tools/filesystem/mkfs.jffs2 -s 0x100 -d rootfs -e 0x10000 --pad=0x400000 -o rootfs.jffs2
rm -rf jffs2.img
mkdir jffs2
../tools/filesystem/mkfs.jffs2 -s 0x100 -d jffs2/ -e 0x10000 --pad=$DATA_SIZE -o jffs2.img
rm -rf jffs2
