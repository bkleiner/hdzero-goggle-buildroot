################################################################################
#
# hdzero-tools
#
################################################################################

HDZERO_TOOLS_VERSION = 0417abf4edee18c23a893cae36a3621aeb50828b
HDZERO_TOOLS_SITE = $(call github,bkleiner,hdzero-goggle-tools,$(HDZERO_TOOLS_VERSION))
HDZERO_TOOLS_INSTALL_STAGING = YES

define HOST_HDZERO_TOOLS_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define HOST_HDZERO_TOOLS_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/update_mbr $(HOST_DIR)/bin/hdz-update_mbr
	$(INSTALL) -D -m 0755 $(@D)/bin/parser_mbr $(HOST_DIR)/bin/hdz-parser_mbr
	$(INSTALL) -D -m 0755 $(@D)/bin/script $(HOST_DIR)/bin/hdz-script
endef

$(eval $(host-generic-package))