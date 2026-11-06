# SPDX-License-Identifier: GPL-2.0
#
# p910nd: USB 打印机 RAW 打印服务器（Bidirectional printer daemon）。
# 复用 OpenWrt 21.02.3 官方预编译 ipk，含 usbmisc hotplug 脚本，
# 插上 USB 打印机即自动启动对应的 p910nd 实例。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=p910nd
PKG_VERSION:=0.97
PKG_RELEASE:=9

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_DIR:=$(PKG_BUILD_DIR)/root

PKG_SOURCE:=p910nd_$(PKG_VERSION)-9_mipsel_24kc.ipk
PKG_SOURCE_URL:=https://downloads.openwrt.org/releases/21.02.3/packages/mipsel_24kc/packages/
PKG_HASH:=4997b280d0b8b673dd12b4dc41b0cabceb0bf6986ca9ef54ee3ad37a7554e10e

include $(INCLUDE_DIR)/package.mk

define Package/p910nd
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Printing
	TITLE:=p910nd - USB printer daemon
	URL:=https://github.com/koenkooi/p910nd
	DEPENDS:=+kmod-usb-printer
endef

define Package/p910nd/description
	p910nd is a small printer daemon intended for diskless Linux hosts.
	It passes data from a network socket to a printer directly, allowing
	a USB printer to be shared over the network (RAW / JetDirect port 9100).
endef

define Package/p910nd/conffiles
/etc/config/p910nd
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

define Package/p910nd/install
	$(CP) $(UNPACK_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,p910nd))
