# Copyright (C) 2014 ParanoidAndroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Add Venture bootanimation based on xxhdpi xhdpi hdpi tvdpi resolution


# VENTURE XXHDPI Devices
ifneq ($(filter venture_bacon venture_d800 venture_d801 venture_d802 venture_d803 venture_d851 venture_honami venture_find5 venture_find7 venture_find7u venture_i9500 venture_jflte venture_ls980 venture_m7 venture_m7spr venture_m7vzw venture_m8 venture_n1 venture_odin venture_sirius venture_vs980 venture_yuga,$(TARGET_PRODUCT)),)
    PRODUCT_COPY_FILES += \
        vendor/venture/prebuilt/bootanimation/1920x1080.zip:system/media/bootanimation.zip
endif

# VENTURE XHDPI Devices
ifneq ($(filter venture_amami venture_aries venture_edison venture_maserasti venture_spyder venture_targa venture_umts_spyder venture_nozomi venture_falcon venture_evita venture_moto_msm8960 moto_msm8960_jbbl venture_d2lte venture_gee venture_geeb venture_hercules venture_i605 venture_i9300 venture_m4 venture_n7000 venture_n7100 venture_skyrocket venture_togari,$(TARGET_PRODUCT)),)
    PRODUCT_COPY_FILES += \
        vendor/venture/prebuilt/bootanimation/1280x720.zip:system/media/bootanimation.zip
endif

# VENTURE HDPI Devices
ifneq ($(filter venture_galaxysmtd venture_i9100 venture_i9100g venture_p3100 venture_p3110 venture_taoshan venture_ville,$(TARGET_PRODUCT)),)
    PRODUCT_COPY_FILES += \
        vendor/venture/prebuilt/bootanimation/800x480.zip:system/media/bootanimation.zip
endif

# VENTURE TVDPI Devices
ifneq ($(filter venture_n5100 venture_n5110 venture_n5120,$(TARGET_PRODUCT)),)
    PRODUCT_COPY_FILES += \
        vendor/venture/prebuilt/bootanimation/1920x1200.zip:system/media/bootanimation.zip
endif