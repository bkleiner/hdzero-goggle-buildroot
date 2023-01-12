################################################################################
#
# hdzero-tools
#
################################################################################

HDZERO_TOOLS_VERSION = 8506952654984fb11e6ab28ac19861df7c85f34e
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
endef

$(eval $(host-generic-package))