#!/bin/bash

# Function to clone repositories
clone_repo() {
    git clone -b $2 $1 $3
}

# Function to apply patches
apply_patch() {
    pushd $1
    git fetch $2 $3
    git cherry-pick $4
    popd
}

# Remove unwanted directories
rm -rf hardware/st/nfc
rm -rf packages/apps/Dialer
rm -rf packages/apps/Contacts
rm -rf packages/apps/Messaging
# rm -rf packages/apps/ExactCalculator
rm -rf packages/resources/devicesettings

# Device repositories
clone_repo "https://github.com/parixxshit/device_xiaomi_spes.git" "13" "device/xiaomi/spes"
clone_repo "https://github.com/parixxshit/device_xiaomi_sm6225-common.git" "13" "device/xiaomi/sm6225-common"
clone_repo "https://github.com/PixelExperience-Devices/device_xiaomi_sm6225-common-miuicamera.git" "thirteen" "device/xiaomi/sm6225-common-miuicamera"

# Kernel repositories
clone_repo "https://github.com/PixelExperience-Devices/kernel_xiaomi_sm6225.git" "thirteen" "kernel/xiaomi/sm6225"
clone_repo "https://github.com/PixelExperience-Devices/device_xiaomi_spes-kernel.git" "thirteen" "device/xiaomi/spes-kernel"

# Vendor blobs repositories
clone_repo "https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_spes.git" "thirteen" "vendor/xiaomi/spes"
clone_repo "https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_sm6225-common.git" "thirteen" "vendor/xiaomi/sm6225-common"
clone_repo "https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_sm6225-common-miuicamera.git" "thirteen" "vendor/xiaomi/sm6225-common-miuicamera"

# Packages repositories
clone_repo "https://github.com/P-404/android_packages_apps_Dialer.git" "tokui" "packages/apps/Dialer"
clone_repo "https://github.com/P-404/android_packages_apps_Contacts.git" "tokui" "packages/apps/Contacts"
clone_repo "https://github.com/P-404/android_packages_apps_Messaging.git" "tokui" "packages/apps/Messaging"
# clone_repo "https://github.com/P-404/android_packages_apps_ExactCalculator.git" "tokui" "packages/apps/ExactCalculator"
clone_repo "https://github.com/PixelExperience/packages_resources_devicesettings.git" "thirteen" "packages/resources/devicesettings"

# Hardware repositories
clone_repo "https://github.com/PixelExperience/hardware_st_nfc.git" "thirteen" "hardware/st/nfc"
clone_repo "https://github.com/PixelExperience/hardware_xiaomi.git" "thirteen" "hardware/xiaomi"
clone_repo "https://github.com/PixelExperience/hardware_qcom-caf_bengal_gps.git" "thirteen" "hardware/qcom-caf/bengal/gps"
clone_repo "https://github.com/PixelExperience/hardware_qcom-caf_bengal_media.git" "thirteen" "hardware/qcom-caf/bengal/media"
clone_repo "https://github.com/PixelExperience/hardware_qcom-caf_bengal_audio.git" "thirteen" "hardware/qcom-caf/bengal/audio"
clone_repo "https://github.com/PixelExperience/hardware_qcom-caf_bengal_display.git" "thirteen" "hardware/qcom-caf/bengal/display"

# Device (QCOM) repositories
clone_repo "https://github.com/PixelExperience-Devices/device_qcom_common.git" "thirteen" "device/qcom/common"
clone_repo "https://github.com/PixelExperience-Devices/device_qcom_qssi.git" "thirteen" "device/qcom/qssi"
clone_repo "https://github.com/PixelExperience-Devices/device_qcom_wlan.git" "thirteen" "device/qcom/wlan"
clone_repo "https://github.com/PixelExperience-Devices/device_qcom_common-sepolicy.git" "thirteen" "device/qcom/common-sepolicy"
clone_repo "https://github.com/PixelExperience-Devices/device_qcom_vendor-common.git" "thirteen" "device/qcom/vendor-common"

# Vendor (QCOM) repositories
clone_repo "https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_qcom_common.git" "thirteen" "vendor/qcom/common"
clone_repo "https://github.com/PixelExperience/vendor_qcom_opensource_core-utils.git" "thirteen" "vendor/qcom/opensource/core-utils"
clone_repo "https://github.com/PixelExperience/vendor_qcom_opensource_commonsys_dpm.git" "thirteen" "vendor/qcom/opensource/commonsys/dpm"
clone_repo "https://github.com/PixelExperience/vendor_qcom_opensource_commonsys-intf_bluetooth.git" "thirteen" "vendor/qcom/opensource/commonsys-intf/bluetooth"

# Patch frameworks/base
apply_patch "frameworks/base" "https://github.com/parixxshit/frameworks_base.git" "8b318b0 50ab912" "8b318b0 50ab912" # Guard BoostFramework with overlay

# Patch vendor/qcom/common
apply_patch "device/qcom/common" "https://github.com/parixxshit/device_qcom_common.git" "feb9d85" "feb9d85" # Adapt FCM for DerpFest

# Patch device/qcom/common-sepolicy
apply_patch "device/qcom/common-sepolicy" "https://github.com/parixxshit/device_qcom_common-sepolicy.git" "1a7aa02" "1a7aa02" # Adapt sepolicy for DerpFest

# Patch packages/apps/Updater
apply_patch "packages/apps/Updater" "https://github.com/parixxshit/packages_apps_Updater.git" "7554a70" "7554a70" # Update server and changelog URL

# Patch vendor/derp
pushd vendor/derp
git fetch https://github.com/parixxshit/vendor_derp.git -t 13-custom
git cherry-pick 95d7761^..cf1f878 # Last 5
# Add: https://github.com/AOSPA/android_vendor_aospa/commit/79d30123868e4943b563598b0a20d3a1aaf33732
# Here: https://github.com/DerpFest-AOSP/vendor_derp/blob/13/config/common.mk "Blur"
popd

# Patch vendor/qcom/opensource/fm-commonsys
apply_patch "vendor/qcom/opensource/fm-commonsys" "https://github.com/PixelExperience/vendor_qcom_opensource_fm-commonsys.git" "74f4211" "74f4211" # Define soong namespace

# Build
. build/envsetup.sh
lunch derp_spes-user && mka derp
