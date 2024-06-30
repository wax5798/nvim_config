local conf = require("modules.completion.config")

local completion = {
    {
        "hrsh7th/nvim-cmp",
        config = conf.cmp,
        event = "InsertEnter",
        dependencies = {
            "lukas-reineke/cmp-under-comparator",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "andersevenrud/cmp-tmux",
            "hrsh7th/cmp-path",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            "kdheepak/cmp-latex-symbols",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = { "nvim-cmp" },
        config = conf.luasnip,
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        dependencies = { "nvim-cmp" },
        config = conf.autopairs,
    },
    {
        "github/copilot.vim",
        lazy = true,
        cmd = "Copilot",
    },
}

return completion
