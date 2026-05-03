
local load_core = function()
    vim.g.mapleader = ","

    if require("core.global").is_windows then
        local bin_dir = vim.fn.stdpath("config") .. "\\bin"
        vim.env.PATH = bin_dir .. ";" .. vim.env.PATH
        if not os.getenv("HOME") then
            vim.fn.setenv("HOME", vim.fn.expand("~"))
        end
    end

    local Lazy = require("core.lazy")

    Lazy.check_and_install()

    require("core.options")

    Lazy.load_plugins()

    require("core.keymap")

    vim.cmd([[colorscheme catppuccin]])
end

load_core()
