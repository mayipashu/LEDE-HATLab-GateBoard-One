# SPDX-License-Identifier: Apache-2.0
#
# luci-app-easytier: vendored from the official EasyTier CBI (classic Lua)
# LuCI app release v2.6.4 — compatible with LuCI 21.02.
# Files under root/ are installed verbatim; the .lmo translation is also
# shipped so the UI is Chinese by default.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-easytier
PKG_VERSION:=2.6.4
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-easytier
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for EasyTier
	URL:=https://github.com/EasyTier/EasyTier
	DEPENDS:=+luci-compat +easytier
	PKGARCH:=all
endef

define Package/luci-app-easytier/description
	LuCI Support for EasyTier (CBI UI, web console not available on mipsel).
endef

define Package/luci-app-easytier/conffiles
/etc/config/easytier
/etc/easytier/config.toml
endef

define Build/Compile
	true
endef

define Package/luci-app-easytier/install
	$(CP) ./root/* $(1)/
	chmod +x $(1)/etc/init.d/easytier
	chmod +x $(1)/etc/uci-defaults/luci-easytier 2>/dev/null || true
	chmod +x $(1)/etc/uci-defaults/luci-i18n-easytier-zh-cn 2>/dev/null || true
endef

$(eval $(call BuildPackage,luci-app-easytier))
