# SPDX-License-Identifier: GPL-2.0
#
# p910nd: USB 打印机 RAW 打印服务器（Bidirectional printer daemon）。
# 新增：包含 HP LaserJet 1020 固件 (sihp1020.dl) 与热插拔自动加载脚本。
# 固件来源：koenkooi/foo2zjs master/sihp1020.img -> arm2hpdl -> sihp1020.dl
# 每次 USB 插入时自动停止 p910nd -> 写固件 -> 重新启动 p910nd。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=p910nd
PKG_VERSION:=0.97
PKG_RELEASE:=10

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_DIR:=$(PKG_BUILD_DIR)/root

PKG_SOURCE:=p910nd_$(PKG_VERSION)-$(PKG_RELEASE)_mipsel_24kc.ipk
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
	FILES:=/usr/sbin/p910nd /etc/init.d/p910nd /usr/share/printer/sihp1020.dl
	CONFIGURE_ARGS+=--with-firmware=/usr/share/printer/sihp1020.dl
endef

define Package/p910nd/description
	p910nd is a small printer daemon intended for diskless Linux hosts.
	It passes data from a network socket to a printer directly, allowing
	a USB printer to be shared over the network (RAW / JetDirect port 9100).
	此版本新增：在 USB 打印机插入时自动下载 HP LaserJet 1020 固件 (sihp1020.dl)，
	该打印机为“无固件”主机型，每次上电/USB 重置后必须先下载固件才能打印。
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

# 热插拔脚本：在 USB 插入时自动加载 HP1020 固件
define Package/p910nd/postinst
	#!/bin/sh
	# 确保固件存在
	[ -f /usr/share/printer/sihp1020.dl ] || {
		echo "固件未找到，请检查安装"
	}
	# 脚本已在 /etc/hotplug.d/usb/20-hp1020 中安装
	ls /etc/hotplug.d/usb/20-hp1020 >/dev/null 2>&1 || {
		echo "热插拔脚本未安装"
	}
endef

define Package/p910nd/install
	$(CP) $(UNPACK_DIR)/* $(1)/
	# 安装热插拔脚本到 /etc/hotplug.d/usb/
	# 文件来源：package/files/etc/hotplug.d/usb/20-hp1020
	$(INST_DIR) $(1)/etc/hotplug.d/usb/
	cp $(PKG_BUILD_DIR)/files/etc/hotplug.d/usb/20-hp1020 $(1)/etc/hotplug.d/usb/20-hp1020
	chmod 755 $(1)/etc/hotplug.d/usb/20-hp1020
	# 确保固件文件在 ipk 中
	$(INST_DIR) $(1)/usr/share/printer/
	cp $(PKG_BUILD_DIR)/files/usr/share/printer/sihp1020.dl $(1)/usr/share/printer/sihp1020.dl
endef

$(eval $(call BuildPackage,p910nd))
