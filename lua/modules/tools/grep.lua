local M = {}

local api = vim.api

local actions = require("telescope.actions")
local config = require("telescope.config")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")

local async = require("plenary.async")

local flatten = utils.flatten

local function apply_picker_config(name, opts)
    opts = opts or {}
    opts.bufnr = opts.bufnr or api.nvim_get_current_buf()
    opts.winnr = opts.winnr or api.nvim_get_current_win()

    local pconf = config.pickers[name] or {}
    local defaults = vim.deepcopy(pconf)

    if defaults.theme then
        defaults = require("telescope.themes")["get_" .. defaults.theme](defaults)
    end

    if pconf.mappings then
        defaults.attach_mappings = function(_, map)
            for mode, tbl in pairs(pconf.mappings) do
                for key, action in pairs(tbl) do
                    map(mode, key, action)
                end
            end
            return true
        end
    end

    if defaults.attach_mappings and opts.attach_mappings then
        local opts_attach = opts.attach_mappings
        opts.attach_mappings = function(prompt_bufnr, map)
            defaults.attach_mappings(prompt_bufnr, map)
            return opts_attach(prompt_bufnr, map)
        end
    end

    return vim.tbl_extend("force", defaults, opts)
end

local function live_grep(opts)
    opts = apply_picker_config("live_grep", opts)

    local vimgrep_arguments = opts.vimgrep_arguments or config.values.vimgrep_arguments

    local additional_args = {}
    if opts.additional_args ~= nil then
        if type(opts.additional_args) == "function" then
            additional_args = opts.additional_args(opts)
        elseif type(opts.additional_args) == "table" then
            additional_args = opts.additional_args
        end
    end

    if opts.type_filter then
        additional_args[#additional_args + 1] = "--type=" .. opts.type_filter
    end

    if type(opts.glob_pattern) == "string" then
        additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern
    elseif type(opts.glob_pattern) == "table" then
        for i = 1, #opts.glob_pattern do
            additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern[i]
        end
    end

    if opts.file_encoding then
        additional_args[#additional_args + 1] = "--encoding=" .. opts.file_encoding
    end

    if opts.hidden then
        additional_args[#additional_args + 1] = "--hidden"
    end

    local args = flatten { vimgrep_arguments, additional_args }
    local cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.uv.cwd()

    local live_grepper = finders.new_job(function(prompt)
        if not prompt or prompt == "" then
            return nil
        end

        local search_list = {}
        if opts.search_dirs then
            for i, path in ipairs(opts.search_dirs) do
                search_list[i] = utils.path_expand(path)
            end
        end

        return flatten { args, "--", prompt, search_list }
    end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), nil, cwd)

    local debounce_ms = tonumber(opts.debounce_ms) or 150
    local timer
    local run_live_grepper = async.void(function(prompt, process_result, process_complete)
        live_grepper(prompt, process_result, process_complete)
    end)
    local debounced_finder = setmetatable({
        close = function()
            if timer then
                timer:stop()
                timer = nil
            end
            live_grepper.close()
        end,
    }, {
        __call = function(_, prompt, process_result, process_complete)
            if timer then
                timer:stop()
            end
            timer = vim.defer_fn(function()
                run_live_grepper(prompt, process_result, process_complete)
            end, debounce_ms)
        end,
    })

    pickers.new(opts, {
        prompt_title = "Live Grep",
        finder = debounced_finder,
        previewer = config.values.grep_previewer(opts),
        sorter = sorters.highlighter_only(opts),
        attach_mappings = function(_, map)
            map("i", "<c-space>", actions.to_fuzzy_refine)
            return true
        end,
    }):find()
end

M.live_grep = live_grep

return M
