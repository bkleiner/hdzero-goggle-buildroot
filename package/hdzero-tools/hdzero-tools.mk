################################################################################
#
# hdzero-tools
#
################################################################################

HDZERO_TOOLS_VERSION = c05aa7b8e85666a812cbf6db2f62716a09238777
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
endef

$(eval $(host-generic-package))