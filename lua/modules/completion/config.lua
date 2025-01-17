local config = {}

function config.cmp()
    -- vim.cmd([[packadd cmp-tabnine]])
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local border = function(hl)
        return {
            { "╭", hl },
            { "─", hl },
            { "╮", hl },
            { "│", hl },
            { "╯", hl },
            { "─", hl },
            { "╰", hl },
            { "│", hl },
        }
    end

    local cmp_window = require("cmp.utils.window")

    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
    end

    local compare = require("cmp.config.compare")

    local cmp = require("cmp")
    cmp.setup({
        window = {
            completion = {
                border = border("CmpBorder"),
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = {
                border = border("CmpDocBorder"),
            },
        },
        sorting = {
            comparators = {
                -- require("cmp_tabnine.compare"),
                compare.offset,
                compare.exact,
                compare.score,
                require("cmp-under-comparator").under,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    -- cmp_tabnine = "[TN]",
                    buffer = "[BUF]",
                    orgmode = "[ORG]",
                    nvim_lua = "[LUA]",
                    path = "[PATH]",
                    tmux = "[TMUX]",
                    luasnip = "[SNIP]",
                    spell = "[SPELL]",
                })[entry.source.name]

                return vim_item
            end,
        },
        -- You can set mappings if you want
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-h>"] = function(fallback)
                if require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
                else
                    fallback()
                end
            end,
            ["<C-l>"] = function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
                else
                    fallback()
                end
            end,
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        -- You should specify your *installed* sources.
        sources = {
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "spell" },
            { name = "tmux" },
            { name = "orgmode" },
            { name = "buffer" },
            { name = "latex_symbols" },
            -- { name = "cmp_tabnine" },
        },
    })
end

function config.luasnip()
    vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.fn.getenv("HOME") .. "/.config/nvim/my-snippets/,"
    require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged,InsertLeave",
    })
    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
end

-- function config.tabnine()
    -- 	local tabnine = require("cmp_tabnine.config")
    -- 	tabnine:setup({ max_line = 1000, max_num_results = 20, sort = true })
    -- end

    function config.autopairs()
        require("nvim-autopairs").setup({})

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        local handlers = require("nvim-autopairs.completion.handlers")
        cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
            filetypes = {
                -- "*" is an alias to all filetypes
                ["*"] = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = handlers["*"],
                    },
                },
                -- Disable for tex
                tex = false,
            },
        })
        )
    end

    return config
