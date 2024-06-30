local conf = require("modules.tools.config")

local tools = {
	{
		-- Plenary是lua模块的集合，其他很多插件对此有依赖
		"nvim-lua/plenary.nvim",
		lazy = false,
		version = 'v0.1.4',
	},
	{
		-- telescope是一个支持模糊搜索的插件，可以用来搜索文字或者文件
		"nvim-telescope/telescope.nvim",
		lazy = true,
		module = "telescope",
		cmd = "Telescope",
		config = conf.telescope,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		version = '0.1.8',
	},
	{
		 -- 它允许telescope使用 fzf 相同的搜索算法
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		dependencies = {"telescope.nvim"},
	},
	{
		-- 支持项目管理，包括创建、删除、查找等
		"nvim-telescope/telescope-project.nvim",
		lazy = true,
		dependencies = {"telescope-fzf-native.nvim"},
	},
	{
		-- 可以根据你的编辑历史智能选择搜索文件的优先级
		"nvim-telescope/telescope-frecency.nvim",
		lazy = true,
		dependencies = {
			"telescope-project.nvim",
			"kkharji/sqlite.lua",
		}
	},
	{
		-- 允许你在neovim中操作zoxide。zoxide is a smarter cd command
		"jvgrootveld/telescope-zoxide",
		lazy = true,
		dependencies = {"telescope-frecency.nvim"},
	},
	--[[
	{
		-- 支持运行各种语言的代码片段
		"michaelb/sniprun",
		lazy = true,
		build = "bash ./install.sh",
		cmd = { "SnipRun", "'<,'>SnipRun" },
	},
	--]]
	{
		-- 可以提示key mapping
		"folke/which-key.nvim",
		lazy = false,
		tag = "stable",
		config = conf.which_key,
	},
	{
		-- 高亮，类似sourceinsight的F8
		"wax5798/nvim_wordshl",
		lazy = false,
		branch = "devo",
		dependencies = {"which-key.nvim"},
		config = conf.wordshl,
	},
	{
		-- 提示代码中的一些警告信息，这些警告信息可能来自telescope或者其他插件的一些诊断结果
		"folke/trouble.nvim",
		lazy = true,
		version = "v2.10.0",
		cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
		config = conf.trouble,
	},
	{
		-- 一个启动时间分析的插件，可以分析neovim启动过程中，其他插件耗时情况
		"dstein64/vim-startuptime",
		lazy = true,
		version = 'v4.5.0',
		cmd = "StartupTime"
	},
	{
		-- 可以理解为增强版的wildmenu
		"gelguy/wilder.nvim",
		event = "CmdlineEnter",
		config = conf.wilder,
		dependencies = {"romgrk/fzy-lua-native"},
	},
	{
		-- 提高 jk 移动性能
		"rhysd/accelerated-jk",
		lazy = false,
	},
	{
		-- 基于ctags命令实现的outline
		"preservim/tagbar",
		lazy = true,
		cmd = "TagbarToggle",
	}
}

return tools
