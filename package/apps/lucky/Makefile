# SPDX-License-Identifier: MIT
#
# lucky: 直接复用 /root/工作/lucky 预编译二进制（mipsel_softfloat）。
# 不再从 GitHub 下载，避免架构不匹配问题。

include $(TOPDIR)/rules.mk

PKG_NAME:=lucky
PKG_VERSION:=3.5.0
PKG_RELEASE:=2

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=GDY666 <gdy666@foxmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/lucky
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lucky network utility
  URL:=https://github.com/gdy666/lucky
  DEPENDS:=@(aarch64||arm||i386||mips||mipsel||riscv64||x86_64) @(!TARGET_gemini)
endef

define Package/lucky/description
 Lucky provides IPv4/IPv6 port forwarding, DDNS, Wake-on-LAN,
 reverse proxy, ACME automation and related network services.
endef

define Package/lucky/conffiles
/etc/config/lucky
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/lucky/install
	$(INSTALL_DIR) $(1)/usr/bin
	# 直接使用包源码目录下的预编译 lucky 二进制
	$(INSTALL_BIN) ./files/lucky $(1)/usr/bin/lucky
	$(INSTALL_DIR) $(1)/usr/libexec
	$(INSTALL_BIN) ./files/lucky-call $(1)/usr/libexec/lucky-call
	$(INSTALL_BIN) ./files/lucky-watchdog $(1)/usr/libexec/lucky-watchdog
	$(INSTALL_DIR) $(1)/usr/share/lucky
	echo 'mipsle_softfloat' > $(1)/usr/share/lucky/arch
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/lucky.init $(1)/etc/init.d/lucky
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/luckyuci $(1)/etc/config/lucky
endef

define Package/lucky/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /usr/libexec/lucky-watchdog sync
endef

define Package/lucky/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ] && [ "$${PKG_UPGRADE}" != 1 ]; then
	/etc/init.d/lucky stop
	/usr/libexec/lucky-watchdog remove
fi
endef

$(eval $(call BuildPackage,lucky))
