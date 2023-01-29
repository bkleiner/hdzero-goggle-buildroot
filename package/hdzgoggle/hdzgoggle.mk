################################################################################
#
# hdzgoggle
#
################################################################################

HDZGOGGLE_VERSION = main
HDZGOGGLE_SITE = $(call github,bkleiner,hdzero-goggle,$(HDZGOGGLE_VERSION))
HDZGOGGLE_INSTALL_STAGING = NO
HDZGOGGLE_INSTALL_TARGET = YES
HDZGOGGLE_DEPENDENCIES = host-pkgconf
HDZGOGGLE_SUPPORTS_IN_SOURCE_BUILD = NO 
HDZGOGGLE_INSTALL_IMAGES = YES

define HDZGOGGLE_INSTALL_IMAGES_CMDS
	cp $(@D)/mkapp/ota_app/app.fex $(BINARIES_DIR)/app.jffs2
	mksquashfs $(@D)/mkapp/app $(BINARIES_DIR)/app.squashfs -noappend -all-root
endef

$(eval $(cmake-package))