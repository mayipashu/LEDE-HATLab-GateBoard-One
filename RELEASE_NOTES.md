**OpenWrt 21.02.3 / Linux 5.4.190** · 设备：HATLab GateBoard-One（MediaTek MT7621）

> 版本命名：`v<年>.<月>.<日>.<序号>`，例如 `v2026.11.07.1`。
> 每次构建都发布一个**独立版本**，历史版本永久保留、可随时回滚；最新版本标记为 `latest`。
> 旧的基础版（不含本次新增功能）归档在 `v2026.11.06-base`。

## 路由与 Web 管理
- **LuCI** 管理界面（Bootstrap 主题，中文/英文），HTTPS 访问（luci-ssl-openssl）
- 防火墙页面 + opkg 软件包管理页面
- 协议支持：PPPoE、IPv6、3G、QMI、Relay
- firewall + iptables + fullconenat、dnsmasq-full

## DHCPv6 / IPv6
- **odhcpd-ipv6only**：IPv6 RA + DHCPv6 服务端，给内网下发 IPv6 地址与 DNS
- **odhcp6c**：WAN 侧 DHCPv6 客户端，支持 v6 前缀委托（PD，可用于整栋下发）
- **ipv6helper**：一键开启 IPv6 转发、NAT6 与 he.net 动态更新
- 内核侧：`kmod-ipv6`、`kmod-ip6tables`、`kmod-ipt-nat6`

## 内网穿透与远程访问
- **frpc 0.34.3**：frp 客户端，把内网服务映射到公网（含 LuCI 界面）
- **lucky 3.5.0**：端口转发、动态域名(DDNS)、反向代理、Wake-on-LAN、
  ACME 自动证书（含 LuCI 界面，支持 IPv4/IPv6）
- **EasyTier 2.6.4**：去中心化组网 / WireGuard 兼容的异地虚拟局域网
  - `easytier-core`、`easytier-cli` 静态二进制，UCI 配置 `/etc/config/easytier`
  - 服务 `/etc/init.d/easytier`，可与 n2n / tinc 并存

## 文件共享
- **Samba4 4.14.12**：SMB/CIFS 文件共享（`smbd`、`nmbd`）
  - LuCI 共享目录管理页面，支持匿名/账号访问、打印机共享
- **FileBrowser 2.23.0**：网页版文件管理器，浏览器内浏览/上传/下载/改名/编辑
  - 默认端口 8989，配置文件 `/etc/config/filebrowser`

## 代理平台（替代 HomeProxy）
- **Xray-core 1.8.3**：VMess / VLESS / Trojan / Shadowsocks / SOCKS / HTTP
  - 内置 `geoip.dat` + `geosite.dat`，支持 GFW 分流、按域名/地区路由
  - **luci-app-xray**：透明代理(TPROXY)、HTTP 代理、SOCKS5、端口转发、
    多服务器负载均衡与故障切换、访问控制
  - 基于 iptables/fw3（本固件年代正确），无需 firewall4
- 说明：HomeProxy 依赖 firewall4 + nftables + ucode + 近 100MB 的 sing-box，
  在 21.02 分支不可用；本固件改用 Xray，功能覆盖同类需求

## IPTV 组播转 HTTP
- **rtp2httpd 3.17.2**（取自 `mayipashu/rtp2httpd`，含"IPTV播放器"定制界面）
  - 把电信/联通组播 RTP/RTSP 直播流转为单播 HTTP 流
  - 内置播放器：`http://路由器IP:端口/player.html`
  - 节目列表：`http://路由器IP:端口/m3u`（可导入任何 IPTV 客户端）
  - 支持 FCC 快速切换、RTSP、HTTP 代理、外部 m3u 源、多实例

## USB 打印机
- **p910nd 0.97**：USB 打印机 RAW/JetDirect 打印服务器（端口 9100）
- **kmod-usb-printer**：USB 打印机内核支持
- 内置 HP LaserJet 1020 固件 `sihp1020.dl`，USB 插入时热插拔脚本
  自动完成固件下载（该机型无自带固件，每次上电都必须重新下载）
- 配合 Samba4 可同时提供 Windows 共享打印

## SFTP
- **openssh-sftp-server 8.4p1**：提供 `/usr/libexec/sftp-server`
- dropbear 2022.82 内置 sftp 子系统，与之配合即可用 SFTP 传输文件
- 保留 dropbear 作为 SSH 服务器，`ssh root@路由器IP` 登录方式不变
- 用法：`sftp root@路由器IP`，或在 FileZilla/WinSCP 中选 SFTP 协议

## VPN
- **n2n 3.0**：`n2n-edge`、`n2n-supernode`、`n2n-benchmark`、`n2n-decode`、`n2n-keygen`
  - UCI 配置 `/etc/config/n2n`，服务 `/etc/init.d/n2n`
- **tinc 1.1pre18**：`/usr/sbin/tincd`，服务 `/etc/init.d/tinc`
- 已内置 `kmod-tun`，n2n/tinc/EasyTier 开箱可用

## 无线
- MT7621 平台无线：`kmod-mt7615e`、`kmod-mt7603`、`kmod-mt76`、`kmod-mt76x2`
- 无线扩展卡：`ath9k`、`ath10k`，含 QCA988x / 99x0 / 9984 / 9888 / 9887 / 9377 / 6174 固件
- `wpad-openssl`（完整 hostapd/wpa_supplicant，支持 WPA2/WPA3 与 802.11r/k/v）

## 蜂窝上网（4G/5G 模块）
- `uqmi`（QMI）、`umbim`（MBIM）、`usb-modeswitch`、`comgt`
- 内核：`kmod-usb-net-qmi-wwan`、`kmod-usb-net-cdc-mbim`、`kmod-usb-net-rndis`、
  `kmod-usb-net-cdc-ether`、`kmod-usb-serial-option`、`kmod-usb3`

## 存储与磁盘
- 根文件系统 ext4，支持 `resize2fs` 扩容
- 文件系统：vfat、exfat、overlay（`kmod-loop` 可挂载镜像）
- 工具：e2fsprogs、resize2fs、losetup、partx-utils、mtd、ethtool、ebtables

## 系统
- dropbear SSH、uhttpd、opkg、openssl-util

## 刷机文件
| 文件 | 说明 |
|---|---|
| `*-ext4-combined.img` | 整机镜像，写盘或 sysupgrade |
| `*-ext4-rootfs.img` | 根文件系统 |
| `*-ext4-kernel.itb` | 内核 |
| `*.manifest` | 已安装软件包清单 |
| `sha256sums` | SHA-256 校验和，刷机前请核对 |
