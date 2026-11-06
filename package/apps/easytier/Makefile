# SPDX-License-Identifier: LGPL-3.0-only
#
# easytier: 使用官方 v2.6.4 预编译 mipsel 静态二进制（官方 Rust 构建，
# 本树无 rust/host，交叉编译不可行）。easytier-web 控制台官方明确不支持
# mips/mipsel，故只集成 easytier-core + easytier-cli，配合 CBI 版 LuCI。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=easytier
PKG_VERSION:=2.6.4
PKG_RELEASE:=1

PKG_LICENSE:=LGPL-3.0-only
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE:=easytier-linux-mipsel-v$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://github.com/EasyTier/EasyTier/releases/download/v$(PKG_VERSION)/
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/easytier
	SECTION:=net
	CATEGORY:=Network
	TITLE:=EasyTier - decentralized mesh VPN with WireGuard support
	URL:=https://github.com/EasyTier/EasyTier
	DEPENDS:=+kmod-tun
endef

define Package/easytier/description
	EasyTier is a simple, safe and decentralized mesh VPN solution.
	Prebuilt static binaries (easytier-core, easytier-cli) for mipsel_24kc.
	The web console is not available on mips/mipsel by upstream design.
endef

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	unzip -q -o $(DL_DIR)/$(PKG_SOURCE) -d $(PKG_BUILD_DIR)
endef

define Build/Compile
	true
endef

define Package/easytier/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/easytier-linux-mipsel/easytier-core $(1)/usr/bin/easytier-core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/easytier-linux-mipsel/easytier-cli $(1)/usr/bin/easytier-cli
endef

$(eval $(call BuildPackage,easytier))
