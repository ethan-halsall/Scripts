#!/bin/bash

actual_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

#Variables
KERNEL_SOURCE_DIR=/home/ethan/Desktop/Kramel/Simple-Kernel
TAG="LA.UM.8.3.r1-07600-sdm845.0"
QCACLD="https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0"
AUDIO="https://source.codeaurora.org/quic/la/platform/vendor/opensource/audio-kernel"
FW_API="https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/fw-api"
QCA_WIFI_HOST_CMN="https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn"


cd ${KERNEL_SOURCE_DIR}
git fetch ${QCACLD} ${TAG} && git subtree merge --prefix=drivers/staging/qcacld-3.0 FETCH_HEAD -m "Merge tag '${TAG}' of ${QCACLD} into ten-dev"
git fetch ${FW_API} ${TAG} && git subtree merge --prefix=drivers/staging/fw-api FETCH_HEAD -m "Merge tag '${TAG}' of ${FW_API} into ten-dev"
git fetch ${QCA_WIFI_HOST_CMN} ${TAG} && git subtree merge --prefix=drivers/staging/qca-wifi-host-cmn FETCH_HEAD -m "Merge tag '${TAG}' of ${QCA_WIFI_HOST_CMN} into ten-dev"
git fetch ${AUDIO} ${TAG} && git subtree merge --prefix=techpack/audio FETCH_HEAD -m "Merge tag '${TAG}' of ${AUDIO} into ten-dev"