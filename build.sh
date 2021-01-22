#!/bin/sh
PWD=`pwd`
export PATH=$PATH:$PWD/tools/arm-linux-gnueabihf-4.9/bin

KERNEL_PATH=$PWD/linux-3.4
UBOOT_PATH=$PWD/u-boot
APP_PATH=$PWD/app-base
PUB_PATH=$PWD/pub
BUILDROOT_PATH=$PWD/buildroot-2017.08
prepare_toolchain()
{
	tar xvf gcc-linaro.tar.bz2
}
build_clean()
{
	cd $KERNEL_PATH
	make clean
	rm -rf output
	cd $PACK_PATH
	rm -rf out
}

build_app()
{
	cd $APP_PATH
	./compile.sh
}
build_kernel()
{
	cd $KERNEL_PATH
#	make ARCH=arm sun8iw8p1smp_zero_diy_defconfig
#	make ARCH=arm menuconfig
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage -j8
	cat .config > ./arch/arm/configs/sun8iw8p1smp_zero_diy_defconfig
	cp arch/arm/boot/uImage ../pub/boot

}
build_uboot()
{
	cd $UBOOT_PATH
	make clean
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
	cp u-boot-sunxi-with-spl.bin ../pub/boot
}
build_rootfs()
{
	cd $BUILDROOT_PATH
	make sunxi_v3s_zero_defconfig
	make menuconfig
	make
	cp -rf output/target/* ../pub/rootfs/
	cd $PUB_PATH
	./mksquashfs.sh
}
build_pack()
{
	cd $PUB_PATH
	./pack.sh
}

build_help()
{
	echo "./build.sh kernel"
	echo "./build.sh uboot"
	echo "./build.sh pack"
	echo "./build.sh all uboot,app,kernel,pack,rootfs"
	echo "./build.sh app"
	echo "./build.sh - app,kernel,pack"
}
case $1 in
	kernel)
		build_kernel
		break;
		;;
	uboot)
		build_uboot
		break;
		;;
	pack)
		build_pack
		break;
		;;
	rootfs)
		build_rootfs
		break;
		;;
	all)
		build_uboot
		build_app
		build_kernel
		build_pack
		break;
		;;
	app)
		build_app
		break;
		;;
	help)
		build_help
		break;
		;;
	*)
		build_help
		break;
		;;
esac
