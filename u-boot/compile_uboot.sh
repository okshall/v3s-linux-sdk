export PATH=$PATH:../tools/arm-linux-gnueabihf-4.9/bin
make clean CROSS_COMPILE=arm-linux-gnueabihf-
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
 cp u-boot-sunxi-with-spl.bin ../pub/boot
