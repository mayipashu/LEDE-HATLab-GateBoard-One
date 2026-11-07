# Copyright (C) 2016 LEDE project

include $(TOPDIR)/rules.mk

PKG_NAME:=openwrt-keyring
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=$(PROJECT_GIT)/keyring.git
PKG_SOURCE_DATE:=2022-03-25
PKG_SOURCE_VERSION:=62471e693b4f9f19dd88afa6827fc3a2cf121d9a
PKG_MIRROR_HASH:=9e1c85c83b61c91f467d8df9bdf94e8a94a85ffbddfcbf3b3dc38a56e98e2516

PKG_MAINTAINER:=John Crispin <john@phrozen.org>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/openwrt-keyring
  SECTION:=base
  CATEGORY:=Base system
  PROVIDES:=lede-keyring
  TITLE:=OpenWrt Developer Keyring
  URL:=https://openwrt.org/docs/guide-user/security/signatures
endef

define Package/openwrt-keyring/description
  The keyring of with the developer using and gpg public keys.
endef

Build/Compile=

define Package/openwrt-keyring/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys/
	# 安装 keyring 仓库里的全部 usign 公钥，而不只是快照那一把。
	#
	# 原版只装 b5043e70f9a75cde（"unattended snapshot builds"），
	# 但本固件 distfeeds 指向 releases/21.02.3，官方发布包是用
	# 2f8b0b98e08306bf（"21.02 release builds"）签名的。
	# 缺这把钥匙时 opkg update 会对每个源报 "Signature check failed"，
	# 并把已下载的 Packages.gz 删掉 —— 结果软件包列表全空、
	# LuCI 里看不到任何可安装软件（已在实际设备上复现并验证修复）。
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/usign/* $(1)/etc/opkg/keys/
endef

$(eval $(call BuildPackage,openwrt-keyring))
