-- ~/.config/nvim/lua/plugins/editor.lua
return {
    -- Formatting: real formatters with LSP fallback, plus format-on-save.
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
                mode = { "n", "v" },
                desc = "Format buffer/selection",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                rust = { "rustfmt" },
                python = { "ruff_format" },
                zig = { "zigfmt" },
                sh = { "shfmt" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                jsonc = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
                markdown = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = function(_)
                return { timeout_ms = 1500, lsp_format = "fallback" }
            end,
        },
    },

    -- Diagnostics / quickfix / symbols list (replaces your custom <leader>xx toggle).
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = { focus = true },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
            { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols outline" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
        },
    },

    -- Auto pairs (lightweight).
    { "echasnovski/mini.pairs", version = false, event = "InsertEnter", opts = {} },

    -- Lua/Neovim API completion + types while editing your config.
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },

    -- Keymap discovery: press <leader> and wait to see what's available.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            spec = {
                { "<leader>f", group = "find / format" },
                { "<leader>g", group = "git" },
                { "<leader>x", group = "diagnostics / lists" },
                { "<leader>L", group = "tabs" },
            },
        },
    },
}
