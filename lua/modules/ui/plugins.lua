local conf = require("modules.ui.config")

local ui = {
	{
		--[[
			显示图标的函数集合。 我们通常不直接与这个插件交互，
			主要是被其他插件使用，让他们显示图标
		--]]
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		-- Neovim主题，启动命令：`vim.cmd([[colorscheme nord]])`
		"shaunsingh/nord.nvim",
		lazy = true,
		config = conf.nord
	},
	{
		-- Neovim主题，启动命令：`vim.cmd([[colorscheme catppuccin]])`
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = conf.catppuccin,
	},
	{
		--[[
			Neovim的一个通知管理插件，可以执行下面命令试试：
			- `:lua require("notify")("My message", "error")`
			- `:lua require("notify")("My message", "error", {title = "error msg"})`
		--]]
		"rcarriga/nvim-notify",
		lazy = true,
		dependencies = {"nvim-tree/nvim-web-devicons"},
		config = conf.notify,
	},
	{
		-- 状态栏插件，从airline迁移过来
		"nvim-lualine/lualine.nvim",
		lazy = true,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = conf.lualine,
	},
	-- ui["SmiteshP/nvim-navic"] = {
	--  -- 依赖LSP，显示当前代码的上下文
	-- 	opt = true,
	-- 	after = "nvim-lspconfig",
	-- 	config = conf.nvim_navic,
	-- }
	{
		-- 可定制的欢迎界面
		"goolord/alpha-nvim",
		lazy = true,
		event = "VimEnter",
		config = conf.alpha,
	},
	{
		-- 文件管理器插件，需要依赖`kyazdani42/nvim-web-devicons`插件，以及NERD字体
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = { "NvimTreeToggle" },
		config = conf.nvim_tree,
	},
	{
		-- git装饰，显示当前代码的git最新提交描述。还能查看修改的内容
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = conf.gitsigns,
		dependencies = {"nvim-lua/plenary.nvim"},
	},
	{
		-- 在当前文件中添加缩进指南
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "BufReadPost",
		config = conf.indent_blankline,
	},
	{
		-- bufferline就是把 buffer 显示成类似 VSCode中 Tab 页的形式
		"akinsho/bufferline.nvim",
		lazy = true,
		event = "BufReadPost",
		config = conf.nvim_bufferline,
	},
	{
		"dstein64/nvim-scrollview",
		lazy = true,
		event = { "BufReadPost" },
		config = conf.scrollview,
	},
	{
		-- 提供强大的撤销更改功能
		"mbbill/undotree",
		lazy = true,
		cmd = "UndotreeToggle",
	},
	--[[
	{
		-- 在屏幕右下角显示LSP工作进度
		"j-hui/fidget.nvim",
		lazy = true,
		version = "legacy",
		event = "BufReadPost",
		config = conf.fidget,
	},
	--]]
}

return ui
