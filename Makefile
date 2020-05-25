export TARGET = iphone:latest:9.0
export ARCHS = arm64
INSTALL_TARGET_PROCESSES = Reddit
include $(THEOS)/makefiles/common.mk

# This doesn't include .x files on purpose so as to easily exclude them
SOURCES = $(wildcard *.xm)
# BLOCKDESC = ../BlockDescription.m

TWEAK_NAME = RedditGold
RedditGold_FILES = $(SOURCES) $(BLOCKDESC)
RedditGold_CFLAGS += -fobjc-arc -Wno-unguarded-availability

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete
