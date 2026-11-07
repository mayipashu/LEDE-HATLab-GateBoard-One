# SPDX-License-Identifier: Apache-2.0
#
# luci-app-filebrowser: 基于上游 luci-app-filebrowser (20260405) 的 LuCI 界面。
# 该版本为 LuCI 经典 Lua CBI 架构（含 status/log 视图模板），
# 与本固件的 LuCI 21.02 兼容。
#
# 与上游的差异：
#   - 二进制由固件预装到 /usr/bin/filebrowser，init 脚本直接使用该路径，
#     不再要求在网页上手动下载到 /tmp。

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-filebrowser
PKG_VERSION:=20260405
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
	DEPENDS:=+luci-compat +filebrowser +luci-lib-jsonc +luci-lib-nixio
	PKGARCH:=all
endef

define Package/luci-app-filebrowser/description
	LuCI configuration page for FileBrowser (classic Lua LuCI).
endef

define Package/luci-app-filebrowser/conffiles
/etc/config/filebrowser
endef

define Build/Compile
	true
endef

define Package/luci-app-filebrowser/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller \
		$(1)/usr/lib/lua/luci/model/cbi/filebrowser \
		$(1)/usr/lib/lua/luci/view/filebrowser \
		$(1)/etc/uci-defaults \
		$(1)/etc/init.d \
		$(1)/etc/config \
		$(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./luasrc/controller/filebrowser.lua $(1)/usr/lib/lua/luci/controller/filebrowser.lua
	$(INSTALL_DATA) ./luasrc/model/cbi/filebrowser/settings.lua $(1)/usr/lib/lua/luci/model/cbi/filebrowser/settings.lua
	$(INSTALL_DATA) ./luasrc/model/cbi/filebrowser/api.lua $(1)/usr/lib/lua/luci/model/cbi/filebrowser/api.lua
	$(INSTALL_DATA) ./luasrc/view/filebrowser/status.htm $(1)/usr/lib/lua/luci/view/filebrowser/status.htm
	$(INSTALL_DATA) ./luasrc/view/filebrowser/log.htm $(1)/usr/lib/lua/luci/view/filebrowser/log.htm
	$(INSTALL_DATA) ./luasrc/view/filebrowser/download.htm $(1)/usr/lib/lua/luci/view/filebrowser/download.htm
	$(INSTALL_BIN) ./root/etc/uci-defaults/luci-app-filebrowser $(1)/etc/uci-defaults/luci-app-filebrowser
	$(INSTALL_BIN) ./root/etc/init.d/filebrowser $(1)/etc/init.d/filebrowser
	$(INSTALL_CONF) ./root/etc/config/filebrowser $(1)/etc/config/filebrowser
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-filebrowser.json $(1)/usr/share/rpcd/acl.d/luci-app-filebrowser.json
endef

define Package/luci-app-filebrowser/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] && exit 0
# LuCI 21.02 用 luci.cacheloader 把 CBI 模型编译成字节码缓存，
# 安装/升级后必须清掉，否则新的模型不会生效（页面显示空白或旧行为）。
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/
killall -HUP rpcd 2>/dev/null
exit 0
endef

$(eval $(call BuildPackage,luci-app-filebrowser))
