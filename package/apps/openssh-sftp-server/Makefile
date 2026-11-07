# SPDX-License-Identifier: GPL-2.0
#
# openssh-sftp-server: 复用 OpenWrt 21.02.3 官方预编译的 sftp-server 二进制。
#
# 背景：
#   dropbear 2022.82 本身已内置 sftp 子系统支持（default_options.h 中
#   DROPBEAR_SFTPSERVER=1，SFTPSERVER_PATH="/usr/libexec/sftp-server"），
#   但 dropbear 不附带 sftp-server 程序本体——它只负责把 "subsystem sftp"
#   请求转发给该路径。因此只需把 OpenSSH 的 sftp-server 装到该路径即可。
#
#   不替换 dropbear 为 openssh-server 的原因：
#     1. 两者都监听 22 端口，替换会让现有 root 密码登录中断；
#     2. openssh 8.4p1 默认 PermitRootLogin prohibit-password（禁止密码登录），
#        与本机 root/admin 的登录方式冲突；
#     3. dropbear 已是默认包，保留它可让 SSH + SFTP 同时可用且风险最低。
#
# 依赖：libcrypto.so.1.1 / libz.so.1（由 libopenssl1.1、zlib 提供，
#       树内默认已含，路由器上已实测存在）。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openssh-sftp-server
PKG_VERSION:=8.4p1
PKG_RELEASE:=5

PKG_LICENSE:=BSD ISC
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_DIR:=$(PKG_BUILD_DIR)/root

PKG_SOURCE:=openssh-sftp-server_$(PKG_VERSION)-4_mipsel_24kc.ipk
PKG_SOURCE_URL:=https://downloads.openwrt.org/releases/21.02.3/packages/mipsel_24kc/packages/
PKG_HASH:=f208ec9f9568fb3592022c3c1c27c98eb5b9260253fa02179f58871d1d4bf15d

include $(INCLUDE_DIR)/package.mk

define Package/openssh-sftp-server
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=SSH
  TITLE:=OpenSSH SFTP server (for dropbear sftp subsystem)
  URL:=http://www.openssh.com/
  DEPENDS:=+libopenssl +zlib
endef

define Package/openssh-sftp-server/description
	OpenSSH SFTP server binary.
	Dropbear 2022.82 has the sftp subsystem compiled in and execs
	/usr/libexec/sftp-server when a client requests "subsystem sftp",
	but does not ship that program itself. Installing this package
	provides the SFTP service alongside the existing dropbear SSH server.
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

define Package/openssh-sftp-server/install
	$(CP) $(UNPACK_DIR)/* $(1)/
	# dropbear 的 SFTPSERVER_PATH 指向 /usr/libexec/sftp-server，
	# 官方 ipk 里它是指向 ../lib/sftp-server 的符号链接，保留即可。
	$(INSTALL_DIR) $(1)/usr/libexec
	ln -sf ../lib/sftp-server $(1)/usr/libexec/sftp-server
endef

$(eval $(call BuildPackage,openssh-sftp-server))
