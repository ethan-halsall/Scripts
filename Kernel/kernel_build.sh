#!/bin/bash

actual_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

#Variables
OUT_DIR=/home/ethan/simple/out
KERNEL_SOURCE_DIR=/home/ethan/simple
CLANG=/home/ethan/clang/bin/clang
GCC=/home/ethan/gcc-8.2/bin/aarch64-linux-gnu-
VER="3.0"

for i in {polaris,dipper,beryllium}
  do
    cd ${KERNEL_SOURCE_DIR}
	make -j12 ARCH=arm64 mrproper
	make -j12 ARCH=arm64 O=${OUT_DIR} mrproper
	make ARCH=arm64 O=${OUT_DIR} simple-"$i"_defconfig

	make -j12 ARCH=arm64 CLANG_TRIPLE=aarch64-linux-gnu- CC=${CLANG} CROSS_COMPILE=${GCC} O=${OUT_DIR}

	zipdirout=${OUT_DIR}/zip-out-temp
	rm -rf ${zipdirout}
	mkdir ${zipdirout}

	cp -r ${KERNEL_SOURCE_DIR}/zip-out/"$i"/* ${zipdirout}/

	cp ${OUT_DIR}/arch/arm64/boot/Image.gz-dtb ${zipdirout}/

	rm -f ${OUT_DIR}/zip-out/simple-*-"$i"-Pie.zip

	cd ${zipdirout}

	release=$(date +%Y""%m""%d"-$VER")
	zipfile="simple-${release}-"$i"-Pie.zip"

	zip -r ${zipfile} * -x .gitignore > /dev/null
	cd ${actual_path}

	rm -f /home/ethan/simple-*-"$i"-Pie.zip
	cp ${zipdirout}/${zipfile} /home/ethan
 done
if [ "$i" == "beryllium" ]; then
	echo "Compile complete flash this shit"
else 
	echo "Compile failed"
fi
