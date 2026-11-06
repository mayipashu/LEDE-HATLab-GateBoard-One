# SPDX-License-Identifier: MPL-2.0
#
# xray-core: 使用 XTLS 官方 v1.8.3 mips32le 预编译静态二进制 + geo 数据。
# immortalwrt 21.02 feed 的 xray-core 1.8.3 需要 go >= 1.20，而该 feed 的
# golang 只有 1.19，源码构建必然失败；官方预编译包与本树工具链无关，
# 是唯一可靠方案。附带 luci-app-xray (fw3/CBI) 提供图形界面。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xray-core
PKG_VERSION:=1.8.3
PKG_RELEASE:=1

PKG_LICENSE:=MPL-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_DIR:=$(PKG_BUILD_DIR)/root

PKG_SOURCE:=Xray-linux-mips32le.zip
PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core/releases/download/v$(PKG_VERSION)/
PKG_HASH:=d1833201ce25940a6ca471aec305e4e9ef75cb20429107b85ffb03f37c68fae5

include $(INCLUDE_DIR)/package.mk

define Package/xray-core
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=Xray - A platform for building proxies
	URL:=https://github.com/XTLS/Xray-core
	DEPENDS:=+ca-bundle
endef

define Package/xray-core/description
	Xray is a platform for building proxies to bypass network restrictions.
	Prebuilt static binary (mips32le) with geoip.dat / geosite.dat bundled.
endef

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(UNPACK_DIR)
	unzip -q -o $(DL_DIR)/$(PKG_SOURCE) -d $(PKG_BUILD_DIR)
endef

define Build/Compile
	true
endef

define Package/xray-core/install
	$(INSTALL_DIR) $(1)/usr/bin
	# 本树 CONFIG_SOFT_FLOAT=y，必须安装软浮点版本，硬浮点在 mipsel_24kc 上会 SIGILL
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/xray_softfloat $(1)/usr/bin/xray
	# geo 数据（可选，默认不打包以节省 11MB；需要时 opkg 装 xray-core-geodata）
endef

$(eval $(call BuildPackage,xray-core))
