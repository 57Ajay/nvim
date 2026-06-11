-- ~/.config/nvim/lua/plugins/treesitter.lua
-- nvim-treesitter `main` branch ONLY. The frozen `master` branch does not work
-- on Neovim 0.12+, so the old dual-version logic is gone.
--
-- One-time requirements on each machine (checked by :checkhealth nvim-treesitter):
--   * tree-sitter CLI >= 0.26.1 (NOT the npm package):
--       mkdir -p ~/.local/bin
--       curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
--         | gunzip > ~/.local/bin/tree-sitter && chmod +x ~/.local/bin/tree-sitter
--   * a C compiler (gcc/clang) and curl on $PATH

local langs = {
    "lua", "vim", "vimdoc", "query",
    "go", "gomod", "gosum", "gowork",
    "typescript", "tsx", "javascript",
    "rust", "python", "zig",
    "c", "cpp",
    -- NOTE: no "jsonc" here — the main branch has no separate jsonc parser;
    -- jsonc buffers automatically use the json parser (get_lang("jsonc") == "json").
    "json", "yaml", "toml",
    "markdown", "markdown_inline",
    "bash", "html", "css",
    "diff", "gitcommit", "git_rebase",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Install parsers (async; no-op if already present).
            require("nvim-treesitter").install(langs)

            -- The rewrite does NOT auto-enable highlighting/indent; start per buffer.
            local function attach(buf)
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)
                if not lang then
                    return
                end
                if pcall(vim.treesitter.start, buf, lang) then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTSStart", { clear = true }),
                callback = function(args)
                    attach(args.buf)
                end,
            })

            -- Buffers already open when this loads at startup.
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    pcall(attach, buf)
                end
            end
        end,
    },

    -- Text objects (main branch): explicit setup + keymaps.
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local ok, to = pcall(require, "nvim-treesitter-textobjects")
            if not ok then
                return
            end
            to.setup({ select = { lookahead = true } })

            local sel = require("nvim-treesitter-textobjects.select").select_textobject
            local move = require("nvim-treesitter-textobjects.move")
            local function map(modes, lhs, fn, desc)
                vim.keymap.set(modes, lhs, fn, { desc = desc })
            end

            map({ "x", "o" }, "af", function() sel("@function.outer", "textobjects") end, "Around function")
            map({ "x", "o" }, "if", function() sel("@function.inner", "textobjects") end, "Inside function")
            map({ "x", "o" }, "ac", function() sel("@class.outer", "textobjects") end, "Around class")
            map({ "x", "o" }, "ic", function() sel("@class.inner", "textobjects") end, "Inside class")
            map({ "x", "o" }, "aa", function() sel("@parameter.outer", "textobjects") end, "Around parameter")
            map({ "x", "o" }, "ia", function() sel("@parameter.inner", "textobjects") end, "Inside parameter")

            map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end,
                "Next function")
            map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end,
                "Prev function")
            map({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end,
                "Next parameter")
            map({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end,
                "Prev parameter")
        end,
    },
}
