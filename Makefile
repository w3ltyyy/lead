ARCHS = arm64 arm64e
TARGET = iphone:16.5:14.0
# xz: the default lzma can't be unpacked by RootHidePatcher's dpkg-deb.
THEOS_PLATFORM_DEB_COMPRESSION_TYPE = xz

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Lead

$(TWEAK_NAME)_FILES = $(shell find Sources \( -name '*.swift' -o -name '*.m' -o -name '*.xm' \))
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/tgapiC/include -Osize
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/tgapiC/include -Wno-deprecated-declarations -Os
$(TWEAK_NAME)_LDFLAGS = -Wl,-dead_strip
$(TWEAK_NAME)_FRAMEWORKS = CoreServices AVFoundation
$(TWEAK_NAME)_LIBRARIES = z
$(TWEAK_NAME)_LOGOS_DEFAULT_GENERATOR = internal
$(TWEAK_NAME)_RESOURCE_FILES = Sources/tgapi/Resources

# Copy Lead.bundle manually during the packaging step
after-stage::
	@echo ">>> Copying Lead.bundle into .deb package..."
	@mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support/Lead
	@cp -a Lead.bundle $(THEOS_STAGING_DIR)/Library/Application\ Support/Lead

include $(THEOS_MAKE_PATH)/tweak.mk

# Also copy the .dylib into packages/ for direct sideload use, and build the
# rootless / RootHide .debs from the same dylib.
after-package::
	@mkdir -p packages
	@cp -f $(THEOS_OBJ_DIR)/Lead.dylib packages/Lead.dylib
	@echo ">>> .dylib copied to packages/Lead.dylib"
	@tools/package_variants.sh
