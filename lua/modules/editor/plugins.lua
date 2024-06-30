local conf = require("modules.editor.config")

local editor = {
	{
		-- 快速对齐的插件，使用下面的文字练习：选中文字，然后敲下'ga='（'='表示按'='对齐）
		"junegunn/vim-easy-align",
		lazy = true,
		cmd = "EasyAlign",
	},
	{
		--[[
		Vim plugin for automatically highlighting other uses of the 
		word under the cursor using either LSP, Tree-sitter, or regex matching
		--]]
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufReadPost",
		config = conf.illuminate,
	},
	{
		-- Toggle comments in Neovim, using built in `commentstring` filetype option
		"terrortylor/nvim-comment",
		lazy = false,
		config = conf.nvim_comment,
	},
	{
		-- 提供高效的代码高亮能力，可以根据不同的语言，安装不同的language parser
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		build = ":TSUpdate",
		event = "BufReadPost",
		version = "v0.9.0",
		config = conf.nvim_treesitter,
	},
	{
		--[[
		提供更丰富的文本对象，可以配置，比如`["af"] = "@function.outer"`。
		我们可以在normal模式下使用vaf选中整个函数内容
		--]]
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		dependencies = {"nvim-treesitter"},
	},
	{
		-- 一个可以使代码中的括号颜色更加丰富的插件
		"p00f/nvim-ts-rainbow",
		lazy = true,
		dependencies = {"nvim-treesitter"},
	},
	--[[
	{
		-- Use treesitter to **autoclose** and **autorename** html tag
		"windwp/nvim-ts-autotag",
		lazy = true,
		dependencies = {"nvim-treesitter"},
		config = conf.autotag,
	},
	--]]
	{
		-- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
		"andymass/vim-matchup",
		lazy = true,
		dependencies = {"nvim-treesitter"},
		config = conf.matchup,
	},
	--[[
	{
		-- Vim-cool disables search highlighting when you are 
		-- done searching and re-enables it when you search again
		"romainl/vim-cool",
		lazy = true,
		event = { "CursorMoved", "InsertEnter" },
	},
	--]]
	{
		-- 类似与easymotion
		"smoka7/hop.nvim",
		lazy = true,
		version = "*",
		event = "BufReadPost",
		config = conf.hop,
	},
	{
		-- a smooth scrolling neovim plugin written in lua
		"karb94/neoscroll.nvim",
		lazy = true,
		event = "BufReadPost",
		config = conf.neoscroll,
	},
	{
		-- 可以在neovim中打开命令终端。TODO：可以使用lazygit，有不同的效果
		"akinsho/toggleterm.nvim",
		lazy = true,
		event = "UIEnter",
		config = conf.toggleterm,
	},
	{
		--[[
		Auto Session takes advantage of Neovim's existing session management 
		capabilities to provide seamless automatic session managemen
		TODO: 没搞懂怎么用
		--]]
		"rmagatti/auto-session",
		lazy = true,
		cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
		config = conf.auto_session,
	},
	{
		-- 一个调试适配的插件。TODO: 后续研究
		"mfussenegger/nvim-dap",
		lazy = true,
		cmd = {
			"DapSetLogLevel",
			"DapShowLog",
			"DapContinue",
			"DapToggleBreakpoint",
			"DapToggleRepl",
			"DapStepOver",
			"DapStepInto",
			"DapStepOut",
			"DapTerminate",
		},
		config = conf.dap,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {"nvim-dap"}, -- Need to call setup after dap has been initialized.
		config = conf.dapui,
	},
	{
		-- 类似于自带的`:bdelete`命令，但是删除buffer的时候不会改变NeoVim窗口布局
		"famiu/bufdelete.nvim",
		lazy = true,
		cmd = { "Bdelete", "Bwipeout" },
	},
	--[[
	{
		-- 允许你使用tab快速的从括号、引用或者类似上下文中跳出来
		"abecodes/tabout.nvim",
		lazy = true,
		event = "InsertEnter",
		wants = "nvim-treesitter",
		dependencies = {"nvim-cmp"},
		config = conf.tabout,
	},
	--]]
	{
		--[[
		该插件旨在提供一个简单、统一的单选项卡页面界面，让你可以轻松地查看任何git版本的所有更改文件。
		使用方式`:DiffviewOpen [git rev] [options] [ -- {paths...}]`
		另外，还可以打开一个新的文件历史视图`:[range]DiffviewFileHistory [paths] [options]`
		--]]
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = { "DiffviewOpen" },
	},
	{
		-- Neovim plugin to stabilize buffer content on window open/close events
		"luukvbaal/stabilize.nvim",
		lazy = true,
		event = "BufReadPost",
	},
}

return editor
