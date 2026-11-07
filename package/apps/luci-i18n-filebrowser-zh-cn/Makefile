# SPDX-License-Identifier: Apache-2.0
#
# luci-i18n-filebrowser-zh-cn: FileBrowser LuCI 界面的简体中文翻译。
# 使用上游 luci-app-filebrowser (20260405) 提供的预编译 .lmo 文件。

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-i18n-filebrowser-zh-cn
PKG_VERSION:=git-26.095.10339-e5f0b2e
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-i18n-filebrowser-zh-cn
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	DEPENDS:=+luci-app-filebrowser
	TITLE:=LuCI support for FileBrowser - 简体中文 (Chinese Simplified)
	PKGARCH:=all
endef

define Package/luci-i18n-filebrowser-zh-cn/description
	Chinese translation for the FileBrowser LuCI interface.
endef

define Build/Compile
	true
endef

define Package/luci-i18n-filebrowser-zh-cn/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./root/usr/lib/lua/luci/i18n/filebrowser.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/filebrowser.zh-cn.lmo
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./root/etc/uci-defaults/luci-i18n-filebrowser-zh-cn $(1)/etc/uci-defaults/luci-i18n-filebrowser-zh-cn
endef

define Package/luci-i18n-filebrowser-zh-cn/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] && exit 0
defaults=/etc/uci-defaults/luci-i18n-filebrowser-zh-cn
[ -f "$$defaults" ] || exit 0
(. "$$defaults") && rm -f "$$defaults"
exit 0
endef

$(eval $(call BuildPackage,luci-i18n-filebrowser-zh-cn))
