-- SPDX-License-Identifier: Apache-2.0

module("luci.controller.filebrowser", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/filebrowser") then
		return
	end

	entry({"admin", "services", "filebrowser"}, cbi("filebrowser"), _("FileBrowser"), 60).dependent = true
end
