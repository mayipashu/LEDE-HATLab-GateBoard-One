-- SPDX-License-Identifier: Apache-2.0
-- CBI 版 rtp2httpd LuCI 界面（兼容 LuCI 21.02 经典 Lua 界面）

local ipc = require "luci.ip"

m = Map("rtp2httpd", translate("rtp2httpd"), translate("把组播 RTP/RTSP 直播流转成单播 HTTP 流，配合内置 IPTV 播放器使用。"))

s = m:section(TypedSection, "rtp2httpd", translate("rtp2httpd"),
	translate("每个实例独立监听一个或多个端口。"))
s.anonymous = true
s.addremove = true

s:option(Flag, "disabled", translate("停用"))
s:option(Flag, "verbose", translate("详细日志"))

l = s:option(DynamicList, "listen", translate("监听地址"),
	translate("格式 host:port，例如 0.0.0.0:8080。可添加多个。"))
l.placeholder = "0.0.0.0:8080"
l.rmempty = false

o = s:option(Value, "upstream_interface", translate("组播上行接口"),
	translate("例如 eth0.3 或 pppoe-wan。留空则自动选择默认接口。"))
o.placeholder = "eth0.3"
o.rmempty = true

o = s:option(Value, "workers", translate("工作线程数"),
	translate("0 表示自动。"))
o.default = "0"

o = s:option(Value, "maxclients", translate("最大客户端数"))
o.default = "0"

o = s:option(Value, "hostname", translate("对外主机名"),
	translate("用于 m3u 播放列表中的链接。"))
o.rmempty = true

o = s:option(Value, "r2h_token", translate("访问令牌"),
	translate("设置后需要通过 ?token= 访问。留空表示无需认证。"))
o.rmempty = true

o = s:option(Value, "external_m3u", translate("外部 m3u 源"),
	translate("可选：从外部 URL 或文件加载节目列表。"))
o.rmempty = true

o = s:option(Value, "app_path_prefix", translate("路径前缀"))
o.rmempty = true

o = s:option(Flag, "video_snapshot", translate("启用视频快照"))

o = s:option(Value, "udp_rcvbuf_size", translate("UDP 接收缓冲"))
o.rmempty = true

o = s:option(Value, "mcast_rejoin_interval", translate("组播重加入间隔（秒）"))
o.rmempty = true

o = s:option(Value, "access_log", translate("访问日志文件路径"),
	translate("留空表示不记录访问日志。"))
o.rmempty = true

o = s:option(Flag, "xff", translate("信任 X-Forwarded-For"))
o = s:option(Flag, "use_relative_path_in_m3u", translate("m3u 中使用相对路径"))

return m
