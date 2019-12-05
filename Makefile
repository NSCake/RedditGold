export TARGET = iphone:latest:9.0
export ARCHS = arm64
include $(THEOS)/makefiles/common.mk

SOURCES = $(wildcard *.xm)
# BLOCKDESC = ../BlockDescription.m

TWEAK_NAME = RedditGold
RedditGold_FILES = $(SOURCES) $(BLOCKDESC)
RedditGold_CFLAGS += -fobjc-arc -Wno-unguarded-availability

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 Reddit"
