m = Map("filebrowser", translate("FileBrowser"), translate("File explorer is software that creates your own cloud that you can install on a server, point it to a path, and then access your files through a beautiful web interface. You have many features available!"))
m:append(Template("filebrowser/status"))

s = m:section(TypedSection, "global", translate("Global Settings"))
s.anonymous = true
s.addremove = false

o = s:option(Flag, "enable", translate("Enable"), translate("<b>The initial password for default user 'admin' is a randomly generated, which appears in the logs upon first startup.</b><br/>The default language is English (others can be selected in Settings - Profile Settings - Language, click UPDATE to change)"))
o.rmempty = false

o = s:option(Value, "address", translate("Listen address"), translate("0.0.0.0 means all addresses，configuring an private address will block internet access"))
o.default = "0.0.0.0"
o.rmempty = false

o = s:option(Value, "port", translate("Listen port"))
o.datatype = "port"
o.default = 8088
o.rmempty = false

o = s:option(Value, "database", translate("Database path"), translate("Paths should not contain spaces; if the file is unavailable, it will be automatically created (including configuration information such as the initial password)"))
o.default = "/etc/filebrowser.db"
o.rmempty = false

o = s:option(Flag, "ssl", translate("Enable SSL"), translate("Access via HTTPS"))
o.default = "0"

o = s:option(Value, "ssl_cert", translate("SSL cert"), translate("SSL certificate file path"))
o.datatype = "file"
o:depends("ssl", "1")

o = s:option(Value, "ssl_key", translate("SSL key"), translate("SSL key file path"))
o.datatype = "file"
o:depends("ssl", "1")

o = s:option(ListValue, "firewall_set", translate("Firewall rules"), translate("Force: Delete and recreate on service start, delete on service stop<br/>Check: Create on service start if none exist; do not delete on service stop"))
o:value("no", translate("Do not set"))
o:value("check", translate("Check"))
o:value("force", translate("Force"))

o = s:option(Value, "root_path", translate("Root path"), translate("Point to a path to access your files in the web interface, default is root directory /"))
o.default = "/"
o.rmempty = false

o = s:option(Value, "extrFlag", translate("Other flags"), translate("Ensure that the current version supports. For example: --disableExec=false enables built-in shell (disabled by default since v2.33.8)"))

o = s:option(Value, "executable_directory", translate("Executable directory"), translate("The file size is large, requiring at least 32M space. It is recommended to insert a usb flash drive or hard disk, or use it in the tmp directory<br />For example, /mnt/sda1<br />For example, /tmp"))
o.default = "/tmp"
o.rmempty = false

o = s:option(Button, "_download", translate("Manually download"), translate("Make sure you have enough space. <br/><font style='color:red'>Be sure to fill out the executable storage directory the first time you run it, and then save the application. Then manually download, otherwise can not use!</font><br/>The download button above depends on the package 'wget-ssl'. Reliable and fast connection to GitHub is required; otherwise, it is prone to report errors or timeouts.<br/>Solution: <br/>1. Go to the <a href='https://github.com/filebrowser/filebrowser/releases' target='_blank'>official repository releases page</a>, use a download manager to download the compressed package for the corresponding architecture, then extract it and store the 'filebrowser' executable in the specified directory.<br/>2. If no external storage (USB drive or hard disk) is available, you can try <a href='https://github.com/upx/upx/releases' target='_blank'>download UPX to compress the executable</a> to save space (but this will consume more RAM)."))
o.template = "filebrowser/download"
o.inputstyle = "apply"
o.btnclick = "downloadClick(this);"
o.id = "download_btn"

m:append(Template("filebrowser/log"))

return m
