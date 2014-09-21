# Copyright (C) 2013 ParanoidAndroid Project
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

ifeq (venture_bacon,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_bacon.mk
endif
ifeq (venture_deb,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_deb.mk
endif
ifeq (venture_flo,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_flo.mk
endif
ifeq (venture_grouper,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_grouper.mk
endif
ifeq (venture_hammerhead,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_hammerhead.mk
endif
ifeq (venture_maguro,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_maguro.mk
endif
ifeq (venture_mako,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_mako.mk
endif
ifeq (venture_manta,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_manta.mk
endif
ifeq (venture_tilapia,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_tilapia.mk
endif
ifeq (venture_toro,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_toro.mk
endif
ifeq (venture_toroplus,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/venture_toroplus.mk
endif