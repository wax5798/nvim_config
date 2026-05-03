local config = {}

function config.telescope()
    -- vim.cmd([[packadd sqlite.lua]])
    -- vim.cmd([[packadd telescope-fzf-native.nvim]])
    -- vim.cmd([[packadd telescope-project.nvim]])
    -- vim.cmd([[packadd telescope-frecency.nvim]])
    -- vim.cmd([[packadd telescope-zoxide]])

    local telescope_actions = require("telescope.actions.set")
    local fixfolds = {
        hidden = true,
        attach_mappings = function(_)
            telescope_actions.select:enhance({
                post = function()
                    vim.cmd(":normal! zx")
                end,
            })
            return true
        end,
    }

    vim.g.sqlite_clib_path = vim.fn.stdpath("data") .. "/lib/sqlite3.dll"

    require("telescope").setup({
        defaults = {
            initial_mode = "insert",
            prompt_prefix = "  ",
            selection_caret = " ",
            entry_prefix = " ",
            scroll_strategy = "limit",
            results_title = false,
            borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            layout_strategy = "horizontal",
            path_display = { "absolute" },
            file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip", "tags" },
            layout_config = {
                prompt_position = "bottom",
                horizontal = {
                    preview_width = 0.5,
                },
            },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        },
        extensions = {
            fzf = {
                fuzzy = false,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
        },
        pickers = {
            buffers = fixfolds,
            find_files = fixfolds,
            git_files = fixfolds,
            grep_string = fixfolds,
            live_grep = fixfolds,
            oldfiles = fixfolds,
        },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("project")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("frecency")
end

function config.trouble()
    require("trouble").setup({
        win = {
            position = "bottom",
            size = 10,
        },
        icons = {
            folder_closed = "",
            folder_open = "",
            kind = {},
        },
        modes = {
            diagnostics = {
                mode = "diagnostics",
                filter = { buf = 0 },
            },
            lsp_references = {
                mode = "lsp_references",
            },
            workspace_diagnostics = {
                mode = "diagnostics",
            },
            document_diagnostics = {
                mode = "diagnostics",
                filter = { buf = 0 },
            },
            quickfix = {
                mode = "qflist",
            },
            loclist = {
                mode = "loclist",
            },
        },
        auto_close = false,
        auto_open = false,
        auto_preview = true,
        auto_fold = false,
    })
end

function config.sniprun()
    require("sniprun").setup({
        selected_interpreters = {}, -- " use those instead of the default for the current filetype
        repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
        repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
        interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
        -- " you can combo different display modes as desired
        display = {
            "Classic", -- "display results in the command-line  area
            "VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
            "VirtualTextErr", -- "display error results as virtual text
            -- "TempFloatingWindow",      -- "display results in a floating window
            "LongTempFloatingWindow", -- "same as above, but only long results. To use with VirtualText__
            -- "Terminal"                 -- "display results in a vertical split
        },
        -- " miscellaneous compatibility/adjustement settings
        inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
        -- " to workaround sniprun not being able to display anything

        borders = "shadow", -- " display borders around floating windows
        -- " possible values are 'none', 'single', 'double', or 'shadow'
    })
end

function config.which_key()
    require("which-key").setup({
        plugins = {
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = true,
                g = true,
            },
        },

        icons = {
            breadcrumb = "»",
            separator = "│",
            group = "+",
        },

		win = {
			border = "none",
			padding = { 1, 1 },
			wo = {
				winblend = 0,
			},
		},
    })
end

function config.wordshl()
    require("nvim_wordshl")
end

function config.wilder()
    vim.cmd([[
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('use_python_remote_plugin', 0)
call wilder#set_option('pipeline', [
    \ wilder#check({_, x -> getcmdtype() !=# ':' || x !~# '^\s*\%(tj\%[ump]\|tse\%[lect]\|ptj\%[ump]\|pts\%[elect]\|pt\%[ag]\|tags\)\>'}),
    \ wilder#branch(
    \   wilder#cmdline_pipeline({'use_python': 0, 'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter(), 'debounce': 150}),
    \   wilder#vim_search_pipeline(),
    \   [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})]
    \   )])
call wilder#set_option('renderer', wilder#renderer_mux({
    \ ':': wilder#popupmenu_renderer({
        \ 'highlighter': wilder#lua_fzy_highlighter(),
        \ 'left': [wilder#popupmenu_devicons()],
        \ 'right': [' ', wilder#popupmenu_scrollbar()]
        \ }),
    \ '/': wilder#wildmenu_renderer({
        \ 'highlighter': wilder#lua_fzy_highlighter(),
        \ 'apply_incsearch_fix': v:true,
        \})
        \ }))
]])
end

function config.remote_ssh()
    -- telescope-remote-buffer setup crashes if keymaps are not provided, removing it for now
    -- require("telescope").load_extension("remote-buffer")

    require("remote-ssh").setup({})
end

function config.filetype()
    -- In init.lua or filetype.nvim's config file
    require("filetype").setup({
        overrides = {
            shebang = {
                -- Set the filetype of files with a dash shebang to sh
                dash = "sh",
            },
        },
    })
end

return config
