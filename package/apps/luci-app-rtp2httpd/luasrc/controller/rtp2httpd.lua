-- SPDX-License-Identifier: Apache-2.0

module("luci.controller.rtp2httpd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/rtp2httpd") then
		return
	end

	entry({"admin", "services", "rtp2httpd"}, cbi("rtp2httpd"), _("rtp2httpd"), 90).dependent = true
	entry({"admin", "services", "rtp2httpd", "status"}, call("action_status")).leaf = true
end

function action_status()
	local uci = require "luci.model.uci".cursor()
	local sys = require "luci.sys"

	luci.http.prepare_content("application/json")
	luci.http.write_json({
		running = (sys.call("pgrep -f '/usr/bin/rtp2httpd' >/dev/null 2>&1") == 0),
		port = uci:get_first("rtp2httpd", "rtp2httpd", "listen", "") or ""
	})
end
