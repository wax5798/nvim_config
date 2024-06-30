local global = require("core.global")

local modules_dir = global.vim_path .. "/lua/modules"

local Lazy = {}

lazy_plugins = {}

local get_plugins_list = function()
	local list = {}
	local tmp = vim.split(vim.fn.globpath(modules_dir, "*/plugins.lua"), "\n")
	for _, f in ipairs(tmp) do
		list[#list + 1] = f:sub(#modules_dir - 6, -1)
	end
	return list
end

function Lazy:check_and_install()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

function Lazy:load_plugins()
	local plugins_list = get_plugins_list()
	lazy_plugins = {}

	for _, m in ipairs(plugins_list) do
		local modules = require(m:sub(0, #m - 4))
		for i = 1, #modules do
			lazy_plugins[#lazy_plugins + 1] = modules[i]
		end
	end

	require("lazy").setup(lazy_plugins)
end


return Lazy
