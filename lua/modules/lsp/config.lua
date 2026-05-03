local config = {}

local server_names = { "clangd", "pyright", "lua_ls", "rust_analyzer", "html", "cssls" }

function config.mason()
    require("mason").setup({
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })
end

function config.mason_lspconfig()
    require("mason-lspconfig").setup({
        ensure_installed = server_names,
        automatic_installation = true,
    })
end

function config.lspconfig()
    require("lspconfig")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
            "clangd",
            "--compile-commands-dir=.vscode/neovim",
            "--header-insertion=never",
            "--background-index",
        },
    })

    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim", "lazy_plugins" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    })

    vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                check = { command = "clippy" },
                linkedProjects = { ".vscode/neovim/rust-project.json" },
            },
        },
    })

    for _, name in ipairs({ "pyright", "html", "cssls" }) do
        vim.lsp.config(name, {
            capabilities = capabilities,
        })
    end

    vim.lsp.enable(server_names)

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>gr", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local win = vim.api.nvim_get_current_win()
                local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/references" })
                if #clients == 0 then
                    vim.notify("No references found", vim.log.levels.INFO)
                    return
                end
                local params = vim.lsp.util.make_position_params(win, clients[1].offset_encoding)
                params.context = { includeDeclaration = true }
                vim.lsp.buf_request(bufnr, "textDocument/references", params, function(err, result, ctx)
                    if err then
                        vim.notify("LSP error: " .. (err.message or vim.inspect(err)), vim.log.levels.ERROR)
                        return
                    end
                    if not result or result == vim.NIL or (type(result) == "table" and #result == 0) then
                        vim.notify("No references found", vim.log.levels.INFO)
                        return
                    end
                    local client = vim.lsp.get_client_by_id(ctx.client_id)
                    local items = vim.lsp.util.locations_to_items(
                        vim.islist(result) and result or { result },
                        client.offset_encoding
                    )
                    if #items == 0 then
                        vim.notify("No references found", vim.log.levels.INFO)
                    else
                        vim.fn.setqflist({}, " ", { title = "References", items = items })
                        vim.cmd("botright copen")
                    end
                end)
            end, opts)
            vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>cf", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, opts)
        end,
    })

    vim.api.nvim_create_user_command("GenerateClangd", function(opts)
        local depth = tonumber(opts.args) or 0
        if depth < 0 then depth = 0 end

        local root = vim.fn.getcwd()
        local clangd_file = root .. "/.clangd"

        local header_patterns = { "**/*.h", "**/*.hpp", "**/*.hxx", "**/*.hh" }
        local dirs = {}

        for _, pattern in ipairs(header_patterns) do
            local files = vim.fn.globpath(root, pattern, false, true)
            for _, f in ipairs(files) do
                local dir = vim.fn.fnamemodify(f, ":h")
                local rel = dir:sub(#root + 2)
                if rel ~= "" and rel ~= "." then
                    dirs[rel] = true
                    for i = 1, depth do
                        local parent = rel
                        for _ = 1, i do
                            parent = parent:match("^(.*)[/\\]")
                        end
                        if parent and parent ~= "" and parent ~= "." then
                            dirs[parent] = true
                        end
                    end
                end
            end
        end

        local sorted_dirs = {}
        for d, _ in pairs(dirs) do
            sorted_dirs[#sorted_dirs + 1] = d
        end
        table.sort(sorted_dirs)

        if #sorted_dirs == 0 then
            vim.notify("No header files found in " .. root, vim.log.levels.WARN)
            return
        end

        local lines = {
            "CompileFlags:",
            "  Add:",
        }
        for _, d in ipairs(sorted_dirs) do
            lines[#lines + 1] = "    - -I" .. d:gsub("\\", "/")
        end

        local f = io.open(clangd_file, "w")
        if f then
            for _, line in ipairs(lines) do
                f:write(line .. "\n")
            end
            f:close()
            vim.notify(
                "Generated " .. clangd_file .. " (" .. #sorted_dirs .. " include paths, depth=" .. depth .. ")",
                vim.log.levels.INFO
            )
        else
            vim.notify("Failed to write " .. clangd_file, vim.log.levels.ERROR)
        end
    end, { nargs = "?", desc = "Generate .clangd config. Optional arg: parent dir depth (default 0)" })

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        float = {
            border = "rounded",
            source = "always",
        },
    })
end

return config
