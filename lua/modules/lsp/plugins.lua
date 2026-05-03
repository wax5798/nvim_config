local conf = require("modules.lsp.config")

local lsp = {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
        config = conf.mason,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            "mason.nvim",
            "nvim-lspconfig",
        },
        config = conf.mason_lspconfig,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mason-lspconfig.nvim",
            "cmp-nvim-lsp",
        },
        config = conf.lspconfig,
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
    },
}

return lsp
