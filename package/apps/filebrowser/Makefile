# SPDX-License-Identifier: Apache-2.0
#
# filebrowser: 复用 immortalwrt 21.02（mipsel_24kc）预编译 ipk。
# 该二进制为 Go 静态编译，与本树工具链无关；构建只需下载 + 解包 + 重打包，
# 因此不引入 golang/host + node/host（CI 上可省 20 分钟以上）。
#

include $(TOPDIR)/rules.mk

PKG_NAME:=filebrowser
PKG_VERSION:=2.23.0
PKG_RELEASE:=2

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=mayipashu

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
UNPACK_DIR:=$(PKG_BUILD_DIR)/root

PKG_SOURCE:=filebrowser_$(PKG_VERSION)-2_mipsel_24kc.ipk
PKG_SOURCE_URL:=https://downloads.immortalwrt.org/releases/21.02.7/packages/mipsel_24kc/packages/
PKG_HASH:=fb3674e1596d9254c261b70a23b64adfe0e96a4aa97e591abca48139b9c650a4

include $(INCLUDE_DIR)/package.mk

define Package/filebrowser
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=FileBrowser - 网页版文件管理器
	URL:=https://github.com/filebrowser/filebrowser
	DEPENDS:=
endef

define Package/filebrowser/description
	filebrowser provides a web file managing interface: upload, delete,
	preview, rename and edit files under a configured root directory.
endef

define Package/filebrowser/conffiles
/etc/config/filebrowser
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

define Package/filebrowser/install
	$(CP) $(UNPACK_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,filebrowser))
