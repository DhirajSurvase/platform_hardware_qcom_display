#Common headers
common_includes := $(LOCAL_PATH)/../libgralloc
common_includes += $(LOCAL_PATH)/../liboverlay
common_includes += $(LOCAL_PATH)/../libcopybit
common_includes += $(LOCAL_PATH)/../libqdutils
common_includes += $(LOCAL_PATH)/../libhwcomposer
common_includes += $(LOCAL_PATH)/../libhdmi
common_includes += $(LOCAL_PATH)/../libqservice

ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_flags     += -DUSES_POST_PROCESSING
    common_includes  += $(TARGET_OUT_HEADERS)/pp/inc
endif

common_header_export_path := qcom/display

#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
common_flags += -Wconversion -Wall -Werror -Wno-sign-conversion

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifeq ($(call is-board-platform-in-list, $(MSM_VIDC_TARGET_LIST)), true)
ifneq ($(TARGET_SUPPORTS_WEARABLES), true)
    common_flags += -DVENUS_COLOR_FORMAT
endif
endif

ifeq ($(call is-board-platform-in-list, msm8974 msm8226 msm8610 apq8084 \
        mpq8092 msm_bronze msm8916 msm8994), true)
    common_flags += -DMDSS_TARGET
endif
ifeq ($(call is-board-platform-in-list, msm8909), true)
ifneq ($(TARGET_SUPPORTS_WEARABLES), true)
    common_flags += -DVENUS_COLOR_FORMAT
endif
    common_flags += -DMDSS_TARGET
endif

common_deps  := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
kernel_includes := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
