#!/bin/bash

actual_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

#Variables
OUT_DIR=/home/ethan/Desktop/Kramel/Simple-Kernel/out
KERNEL_SOURCE_DIR=/home/ethan/Desktop/Kramel/Simple-Kernel
CLANG=/home/ethan/Desktop/Kramel/Clang-11.0.0/bin/clang
GCC=/home/ethan/Desktop/Kramel/arm64-gcc/bin/aarch64-elf-
#GCC=/home/ethan/Desktop/Kramel/4.9-gcc/bin/aarch64-linux-android-
GCC32=/home/ethan/Desktop/Kramel/gcc-32/bin/arm-linux-androideabi-
#CACHE = ccache


cd ${KERNEL_SOURCE_DIR}
make -j12 ARCH=arm64 mrproper
make -j12 ARCH=arm64 O=${OUT_DIR} mrproper
make ARCH=arm64 O=${OUT_DIR} simple-polaris_defconfig

make -j12 ARCH=arm64 CLANG_TRIPLE=aarch64-linux-gnu- CC="ccache ${CLANG}" CROSS_COMPILE=${GCC} CROSS_COMPILE_ARM32=${GCC32} O=${OUT_DIR}
#make -j12 ARCH=arm64 CROSS_COMPILE="ccache ${GCC}" CROSS_COMPILE_ARM32=${GCC32} O=${OUT_DIR}

zipdirout=${OUT_DIR}/zip-out-temp
rm -rf ${zipdirout}
mkdir ${zipdirout}

cp -r ${KERNEL_SOURCE_DIR}/zip-out/* ${zipdirout}/

cp ${OUT_DIR}/arch/arm64/boot/Image.gz-dtb ${zipdirout}/

rm -f ${OUT_DIR}/zip-out/simple-*-polaris-Pie.zip

cd ${zipdirout}

release=$(date +%Y""%m""%d)
zipfile="simple-${release}-polaris-clang-11.0.0.zip"

zip -r ${zipfile} * -x .gitignore > /dev/null
cd ${actual_path}

rm -f /home/ethan/simple-*-dipper-Pie.zip

rm -f /home/ethan/Desktop/Kramel/simple-*-polaris-Pie.zip
cp ${zipdirout}/${zipfile} /home/ethan/Desktop/Kramel
