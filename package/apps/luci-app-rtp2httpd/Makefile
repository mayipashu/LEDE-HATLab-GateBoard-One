include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rtp2httpd
PKG_VERSION:=3.17.2
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-rtp2httpd
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for rtp2httpd (CBI)
	URL:=https://github.com/mayipashu/rtp2httpd
	DEPENDS:=+luci-compat +rtp2httpd
	PKGARCH:=all
endef

define Package/luci-app-rtp2httpd/description
	CBI-style LuCI configuration page for rtp2httpd.
	Compatible with classic Lua LuCI (21.02).
endef

define Build/Compile
	true
endef

define Package/luci-app-rtp2httpd/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller \
		$(1)/usr/lib/lua/luci/model/cbi \
		$(1)/usr/lib/lua/luci/view/rtp2httpd \
		$(1)/etc/uci-defaults \
		$(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./luasrc/controller/rtp2httpd.lua $(1)/usr/lib/lua/luci/controller/rtp2httpd.lua
	$(INSTALL_DATA) ./luasrc/model/cbi/rtp2httpd.lua $(1)/usr/lib/lua/luci/model/cbi/rtp2httpd.lua
	$(INSTALL_DATA) ./luasrc/view/rtp2httpd/rtp2httpd_status.htm $(1)/usr/lib/lua/luci/view/rtp2httpd/rtp2httpd_status.htm
	$(INSTALL_BIN) ./root/etc/uci-defaults/luci-rtp2httpd $(1)/etc/uci-defaults/luci-rtp2httpd
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-rtp2httpd.json $(1)/usr/share/rpcd/acl.d/luci-app-rtp2httpd.json
endef

$(eval $(call BuildPackage,luci-app-rtp2httpd))
