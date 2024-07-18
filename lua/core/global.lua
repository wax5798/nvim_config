local global = {}
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.is_windows = os_name == "Windows_NT"
	self.vim_path = vim.fn.stdpath("config")
	local path_sep = self.is_windows and "\\" or "/"
	local home = self.is_windows and vim.fn.getenv("USERPROFILE") or vim.fn.getenv("HOME")
	self.cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep
	self.modules_dir = self.vim_path .. path_sep .. "modules"
	self.home = home
	self.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
    self.shell = "\"D:\\Program Files\\Git\\bin\\bash.exe\""

	if global.is_mac then
		self.python_host_prog = "/usr/bin/python"
		self.python3_host_prog = "/usr/local/bin/python3"
	elseif global.is_windows then
		self.python_host_prog = "D:\\Program Files\\Python310\\python.exe"
		self.python3_host_prog = "D:\\Program Files\\Python310\\python3.exe"
	else
		self.python_host_prog = "/usr/bin/python"
		self.python3_host_prog = "/usr/bin/python3"
	end
end

global:load_variables()

return global
