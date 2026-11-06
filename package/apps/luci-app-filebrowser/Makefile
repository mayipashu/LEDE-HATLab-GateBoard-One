include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-filebrowser
PKG_VERSION:=2.23.0
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-filebrowser
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for FileBrowser
	URL:=https://github.com/filebrowser/filebrowser
	DEPENDS:=+luci-compat +filebrowser
	PKGARCH:=all
endef

define Package/luci-app-filebrowser/description
	CBI-style LuCI configuration page for FileBrowser (classic Lua LuCI).
endef

define Build/Compile
	true
endef

define Package/luci-app-filebrowser/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller \
		$(1)/usr/lib/lua/luci/model/cbi \
		$(1)/etc/uci-defaults \
		$(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./luasrc/controller/filebrowser.lua $(1)/usr/lib/lua/luci/controller/filebrowser.lua
	$(INSTALL_DATA) ./luasrc/model/cbi/filebrowser.lua $(1)/usr/lib/lua/luci/model/cbi/filebrowser.lua
	$(INSTALL_BIN) ./root/etc/uci-defaults/luci-filebrowser $(1)/etc/uci-defaults/luci-filebrowser
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-filebrowser.json $(1)/usr/share/rpcd/acl.d/luci-app-filebrowser.json
endef

$(eval $(call BuildPackage,luci-app-filebrowser))
