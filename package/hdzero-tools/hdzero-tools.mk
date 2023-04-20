################################################################################
#
# hdzero-tools
#
################################################################################

HDZERO_TOOLS_VERSION = 66703c7b12278857dad3483e9c9080758dca819d
HDZERO_TOOLS_SITE = $(call github,bkleiner,hdzero-goggle-tools,$(HDZERO_TOOLS_VERSION))
HDZERO_TOOLS_INSTALL_STAGING = YES

define HOST_HDZERO_TOOLS_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define HOST_HDZERO_TOOLS_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/update_mbr $(HOST_DIR)/bin/hdz-update_mbr
	$(INSTALL) -D -m 0755 $(@D)/bin/parser_mbr $(HOST_DIR)/bin/hdz-parser_mbr
	$(INSTALL) -D -m 0755 $(@D)/bin/script $(HOST_DIR)/bin/hdz-script
	$(INSTALL) -D -m 0755 $(@D)/bin/u_boot_env_gen $(HOST_DIR)/bin/hdz-u_boot_env_gen
	$(INSTALL) -D -m 0755 $(@D)/bin/dragonsecboot $(HOST_DIR)/bin/hdz-dragonsecboot
	$(INSTALL) -D -m 0755 $(@D)/bin/sunxi-image $(HOST_DIR)/bin/sunxi-image
endef

$(eval $(host-generic-package))