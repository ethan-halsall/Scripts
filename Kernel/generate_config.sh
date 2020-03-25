#!/bin/bash

actual_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

KERNEL_SOURCE_DIR=/home/ethan/Desktop/Kramel/Simple-Kernel

cd ${KERNEL_SOURCE_DIR}

for i in {revenge,polaris,dipper,beryllium}
  do
    if [ "$i" == "polaris" ] || [ "$i" == "dipper" ] || [ "$i" == "beryllium" ]; then
	    ARCH=arm64 make defconfig KBUILD_DEFCONFIG=simple-"$i"_defconfig
        mv .config ${KERNEL_SOURCE_DIR}/arch/arm64/configs/simple-"$i"_defconfig
    else 
        ARCH=arm64 make defconfig KBUILD_DEFCONFIG=revenge_defconfig
        mv .config ${KERNEL_SOURCE_DIR}/arch/arm64/configs/"$i"_defconfig
    fi
    echo "Generating defconfig for: "$i""
 done

git add ${KERNEL_SOURCE_DIR}/arch
git commit -m "arch/arm64: regen configs"
