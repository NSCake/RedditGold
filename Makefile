export TARGET = iphone:latest:9.0
export ARCHS = arm64 arm64e armv7s
INSTALL_TARGET_PROCESSES = Reddit
include $(THEOS)/makefiles/common.mk

# This doesn't include .x files on purpose so as to easily exclude them
SOURCES = $(wildcard *.xm)
# BLOCKDESC = ../includes/BlockDescription.m

TWEAK_NAME = RedditGold
$(TWEAK_NAME)_FILES = $(SOURCES) $(BLOCKDESC)
#$(TWEAK_NAME)_LIBRARIES = flex
$(TWEAK_NAME)_CFLAGS += -fobjc-arc -Wno-unguarded-availability

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete
