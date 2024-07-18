
local load_core = function()
	vim.g.mapleader = ","

	local Lazy = require("core.lazy")

	Lazy.check_and_install()

	require("core.options")

	Lazy.load_plugins()

	require("core.keymap")
	require("core.events")

	vim.cmd([[colorscheme catppuccin]])
end

load_core()
