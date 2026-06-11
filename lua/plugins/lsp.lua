-- ~/.config/nvim/lua/plugins/lsp.lua
-- Servers are configured with vim.lsp.config() and activated with
-- vim.lsp.enable() (mason-lspconfig does the enabling for installed servers).
-- nvim-lspconfig is kept purely as the data source of per-server defaults.
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            -- Diagnostics UI
            vim.diagnostic.config({
                severity_sort = true,
                virtual_text = { spacing = 2, prefix = "●" },
                float = { border = "rounded", source = true },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

            -- Completion capabilities advertised to every server come from blink.cmp.
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            -- Per-server overrides (merged on top of the "*" defaults).
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim", "Snacks" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        gofumpt = true,
                        analyses = { unusedparams = true, nilness = true, unusedwrite = true },
                        staticcheck = true,
                    },
                },
            })

            -- Install + auto-enable servers. Edit this list to taste.
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "ts_ls",
                    "rust_analyzer",
                    "pyright",
                    "ruff",
                    "zls",
                    "clangd",
                },
                automatic_enable = true, -- calls vim.lsp.enable() for installed servers
            })

            -- Buffer-local keymaps when a server attaches.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
                callback = function(ev)
                    local buf = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- pyright owns hover docs; ruff stays for lint + fixes.
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end

                    local function map(keys, fn, desc)
                        vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
                    end

                    -- Navigation goes through the fast snacks picker.
                    map("gd", function() Snacks.picker.lsp_definitions() end, "Definition")
                    map("gD", vim.lsp.buf.declaration, "Declaration")
                    map("gr", function() Snacks.picker.lsp_references() end, "References")
                    map("gi", function() Snacks.picker.lsp_implementations() end, "Implementation")
                    map("gt", function() Snacks.picker.lsp_type_definitions() end, "Type definition")

                    map("K", vim.lsp.buf.hover, "Hover docs")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    -- (Document formatting is <leader>f via conform.nvim.)
                    -- (Signature help is <C-s> in insert mode, a 0.11+ default —
                    --  this avoids clobbering your <C-k> window-up keymap.)
                end,
            })
        end,
    },

    -- Auto-install formatter binaries used by conform.nvim, so format-on-save
    -- works out of the box. (gofmt/rustfmt/zigfmt/ruff come with toolchains.)
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = { "stylua", "shfmt", "prettierd", "goimports" },
            run_on_start = true,
            start_delay = 3000, -- don't compete with startup
        },
    },
}
