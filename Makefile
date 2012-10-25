ARCHS = armv7

include theos/makefiles/common.mk

TWEAK_NAME = Olympus
Olympus_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
