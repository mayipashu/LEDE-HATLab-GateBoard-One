# SPDX-License-Identifier: Apache-2.0
#
# frpc: 直接复用 OpenWrt 21.02.3 官方预编译 ipk（纯静态 Go 二进制，
# 与本树工具链无关），构建时只做"下载 + 解包 + 重打包"，无需 golang/host。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=frpc
PKG_VERSION:=0.34.3
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE:=frpc_$(PKG_VERSION)-1_mipsel_24kc.ipk
PKG_SOURCE_URL:=https://downloads.openwrt.org/releases/21.02.3/packages/mipsel_24kc/packages/
PKG_HASH:=e1f8c2d567f94e6d6894f3e1cc7b3257793fb7cdd78ae1f6640a51f26747a01a

UNPACK_DIR:=$(PKG_BUILD_DIR)/root

include $(INCLUDE_DIR)/package.mk

define Package/frpc
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=frpc - fast reverse proxy client
	URL:=https://github.com/fatedier/frp
	DEPENDS:=
endef

define Package/frpc/description
	frpc is the client of frp, a fast reverse proxy that helps expose
	a local server behind NAT or firewall to the internet.
endef

define Package/frpc/conffiles
/etc/config/frpc
/etc/frp/frpc.d/frpc_full.ini
endef

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(UNPACK_DIR)
	$(TAR) -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR) ./data.tar.gz
	$(TAR) -xzf $(PKG_BUILD_DIR)/data.tar.gz -C $(UNPACK_DIR)
	rm -f $(PKG_BUILD_DIR)/data.tar.gz $(PKG_BUILD_DIR)/control.tar.gz $(PKG_BUILD_DIR)/debian-binary
endef

define Build/Compile
	true
endef

define Package/frpc/install
	$(CP) $(UNPACK_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,frpc))
