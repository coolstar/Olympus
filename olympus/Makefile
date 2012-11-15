include theos/makefiles/common.mk

BUNDLE_NAME = Olympus
Olympus_FILES = Olympus.mm
Olympus_INSTALL_PATH = /Library/PreferenceBundles
Olympus_FRAMEWORKS = UIKit
Olympus_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Olympus.plist$(ECHO_END)
