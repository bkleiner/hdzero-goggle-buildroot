################################################################################
#
# hdzgoggle
#
################################################################################

HDZGOGGLE_VERSION = toolchain-rebase
HDZGOGGLE_SITE = $(call github,bkleiner,hdzero-goggle,$(HDZGOGGLE_VERSION))
HDZGOGGLE_INSTALL_STAGING = NO
HDZGOGGLE_INSTALL_TARGET = YES
HDZGOGGLE_CONF_OPTS = -DUSE_SYSTEM_ZLIB=ON -DUSE_SYSTEM_ALSA_LIB=ON -DUSE_SYSTEM_GLOG=ON
HDZGOGGLE_DEPENDENCIES = host-pkgconf zlib alsa-lib glog
HDZGOGGLE_SUPPORTS_IN_SOURCE_BUILD = NO 
HDZGOGGLE_INSTALL_IMAGES = YES

define HDZGOGGLE_INSTALL_IMAGES_CMDS
	cp $(@D)/mkapp/image/app.fex $(BINARIES_DIR)/
endef

$(eval $(cmake-package))