################################################################################
#
# hdzgoggle
#
################################################################################

HDZGOGGLE_VERSION = softwinner-install-target
HDZGOGGLE_SITE = $(call github,bkleiner,hdzero-goggle,$(HDZGOGGLE_VERSION))
HDZGOGGLE_INSTALL_STAGING = NO
HDZGOGGLE_INSTALL_TARGET = YES
HDZGOGGLE_DEPENDENCIES = host-pkgconf
HDZGOGGLE_SUPPORTS_IN_SOURCE_BUILD = NO 
HDZGOGGLE_INSTALL_IMAGES = YES

define HDZGOGGLE_EXTRACT_MEDIA
	cat $(@D)/media.tar.gzaa $(@D)/media.tar.gzab | tar xz -C$(@D)
endef

HDZGOGGLE_PRE_CONFIGURE_HOOKS += HDZGOGGLE_EXTRACT_MEDIA

define HDZGOGGLE_INSTALL_IMAGES_CMDS
	mksquashfs $(@D)/mkapp/app $(BINARIES_DIR)/app.fex -noappend -all-root
endef

$(eval $(cmake-package))