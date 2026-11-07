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
	# 上游 ipk 自带一份 /etc/init.d/filebrowser，但它读的是
	# `config filebrowser 'config'` 这套旧节名；本固件改用
	# luci-app-filebrowser 提供的适配版脚本（读 `config global`，
	# 并直接用预装的 /usr/bin/filebrowser）。
	#
	# 两者若同时安装，opkg 会因 check_data_file_clashes 报
	#   Package luci-app-filebrowser wants to install .../etc/init.d/filebrowser
	#   But that file is already provided by package filebrowser
	# 导致整个镜像构建在 package/install 阶段失败。
	# 同理 /etc/config/filebrowser 也统一由 luci-app-filebrowser 提供，
	# 避免两个包各自带不同 schema 的同名配置文件。
	rm -f $(1)/etc/init.d/filebrowser
	rm -f $(1)/etc/config/filebrowser
endef

$(eval $(call BuildPackage,filebrowser))
