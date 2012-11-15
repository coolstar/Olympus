ARCHS = armv7

include theos/makefiles/common.mk

TWEAK_NAME = Olympus

Olympus_FILES = Tweak.xm $(wildcard Classes/*.m)

Olympus_FRAMEWORKS = UIKit Foundation Social Accounts CoreTelephony CoreGraphics

Olympus_LDFLAGS = -lactivator -Llib/

THEOS_BUILD_DIR = debs/

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += olympus
include $(THEOS_MAKE_PATH)/aggregate.mk
