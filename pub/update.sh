#!/bin/sh
. ./parts.cfg
TOOL_PATH=../tools/sunxi-tools/sunxi-fel

update_uboot()
{
  $TOOL_PATH -p spiflash-write $UBOOT_OFFSET  ./boot/u-boot-sunxi-with-spl.bin
}
update_script()
{	
  $TOOL_PATH -p spiflash-write $SCRIPT_OFFSET ./boot/script.bin 
}
update_uImage()
{
 $TOOL_PATH -p spiflash-write $UIMAGE_OFFSET ./boot/uImage 
}

update_rootfs()
{
  $TOOL_PATH -p spiflash-write $ROOTFS_OFFSET rootfs.squashfs
}

update_data()
{
  
 $TOOL_PATH -p spiflash-write $DATA_OFFSET jffs2.img
}
help()
{
	echo "update.sh uimage|script|uboot|rootfs|all"
}

case $1 in
	uimage)
		update_uImage
		break;
	;;
	script)
		update_script
		break;
	;;
	uboot)
		update_uboot
		break;
	;;
	rootfs)
		update_rootfs
		break;
	;;
	all)
		update_uboot
		update_script
		update_uImage
		update_rootfs
		update_data
		break;
	;;
	*)
		help
		break;
	;;
esac
