ARCHS = armv7

include theos/makefiles/common.mk

TWEAK_NAME = Olympus

Olympus_FILES = Tweak.xm OLWiFiToggle.m
Olympus_FRAMEWORKS = UIKit Foundation 
Olympus_LDFLAGS = -lactivator -Llib/

THEOS_BUILD_DIR = debs/

include $(THEOS_MAKE_PATH)/tweak.mk
