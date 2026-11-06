-- SPDX-License-Identifier: Apache-2.0
-- CBI 版 FileBrowser 管理界面（兼容 LuCI 21.02 经典 Lua 界面）

m = Map("filebrowser", translate("FileBrowser"), translate("网页版文件管理器，可在浏览器中浏览、上传、下载、重命名、编辑路由器上的文件。"))

s = m:section(TypedSection, "config", translate("基本设置"))
s.anonymous = true

o = s:option(Flag, "enabled", translate("启用"))
o.rmempty = false

o = s:option(Value, "listen_port", translate("监听端口"))
o.datatype = "port"
o.default = "8989"
o.rmempty = false

o = s:option(Value, "root_path", translate("根目录"),
	translate("FileBrowser 只能管理该目录下的文件，建议填 /mnt 或 / 视需求而定。"))
o.default = "/"
o.rmempty = false

o = s:option(Value, "base_url", translate("URL 前缀"),
	translate("可选，例如 /files。留空则直接使用根路径。"))
o.rmempty = true

o = s:option(Flag, "disable_exec", translate("禁用命令执行"),
	translate("出于安全考虑建议保持启用。"))
o.default = "1"
o.rmempty = false

o = s:option(DummyValue, "fb_url", translate("访问地址"),
	translate("配置并保存后，用浏览器打开下列地址（默认账号 admin / admin）。"))
function o.cfgvalue(self, section)
	local port = self.map:confvalue("listen_port") or "8989"
	return "http://路由器IP:" .. port .. "/"
end

return m
