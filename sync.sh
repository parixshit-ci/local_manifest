# Remove
rm -rf device/qcom/common
rm -rf hardware/xiaomi
rm -rf hardware/st/nfc
rm -rf vendor/qcom/opensource/fm-commonsys
rm -rf vendor/qcom/opensource/interfaces

# Device
git clone --depth=1 -b tiramisu https://github.com/parixshit-ci/device_xiaomi_spes.git device/xiaomi/spes
git clone --depth=1 -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone --depth=1 -b thirteen https://github.com/PixelExperience-Devices/device_xiaomi_spes-kernel.git device/xiaomi/spes-kernel
git clone --depth=1 -b thirteen https://github.com/PixelExperience-Devices/kernel_xiaomi_sm6225.git kernel/xiaomi/sm6225
git clone --depth=1 -b tiramisu https://github.com/parixshit-ci/device_xiaomi_sm6225-common.git device/xiaomi/sm6225-common
git clone --depth=1 -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_sm6225-common.git vendor/xiaomi/sm6225-common

# Hardware
git clone --depth=1 -b thirteen https://github.com/PixelExperience/hardware_xiaomi.git hardware/xiaomi
git clone --depth=1 -b thirteen https://github.com/PixelExperience/hardware_st_nfc.git hardware/st/nfc

# Device (QCOM)
git clone --depth=1 -b tiramisu https://github.com/parixshit-ci/device_qcom_common.git device/qcom/common
git clone --depth=1 -b thirteen https://github.com/PixelExperience-Devices/device_qcom_wlan.git device/qcom/wlan
git clone --depth=1 -b tiramisu https://github.com/parixshit-ci/device_qcom_common-sepolicy.git device/qcom/common-sepolicy
git clone --depth=1 -b thirteen https://github.com/PixelExperience-Devices/device_qcom_qssi.git device/qcom/qssi
git clone --depth=1 -b thirteen https://github.com/PixelExperience-Devices/device_qcom_vendor-common.git device/qcom/vendor-common

# Vendor (QCOM)
git clone --depth=1 -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_qcom_common.git vendor/qcom/common
git clone --depth=1 -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_core-utils.git vendor/qcom/opensource/core-utils
git clone --depth=1 -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_fm-commonsys.git vendor/qcom/opensource/fm-commonsys
git clone --depth=1 -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_interfaces.git vendor/qcom/opensource/interfaces
git clone --depth=1 -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_commonsys_dpm.git vendor/qcom/opensource/commonsys/dpm
git clone --depth=1 -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_commonsys-intf_bluetooth.git vendor/qcom/opensource/commonsys-intf/bluetooth

. build/envsetup.sh
lunch evolution_spes-user
mka evolution
