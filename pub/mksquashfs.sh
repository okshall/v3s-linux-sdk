#!/bin/sh
rm -rf rootfs.squashfs
cp -rf rootfs_extra/* rootfs/
../tools/filesystem/mksquashfs rootfs/ rootfs.squashfs
