ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:12.0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

FINALPACKAGE = 1
DEBUG = 0
FOR_RELEASE = 1

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTNoShorts
$(TWEAK_NAME)_FILES = $(filter-out Tweak.m, $(wildcard *.mm *.m *.xm))
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	$(ECHO_NOTHING)find . -name ".DS_Store" -type f -delete$(ECHO_END)

