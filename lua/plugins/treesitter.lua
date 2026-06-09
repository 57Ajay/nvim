-- if there is issue with tree-sitter then run following command to install it
------------------------------------------------------------------------------------
-- mkdir -p ~/.local/bin
-- curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
--   | gunzip > ~/.local/bin/tree-sitter
-- chmod +x ~/.local/bin/tree-sitter

local langs = {
    "lua", "vim", "vimdoc", "query",
    "go", "gomod", "gosum", "gowork",
    "typescript", "tsx", "javascript",
    "rust", "python", "zig",
    "c", "cpp",
    "json", "jsonc", "yaml", "toml",
    "markdown", "markdown_inline",
    "bash", "html", "css",
    "diff", "gitcommit", "git_rebase",
}

----------------------------------------------------------------------
-- Neovim 0.11: master branch (your laptop)
----------------------------------------------------------------------
if vim.fn.has("nvim-0.12") == 0 then
    return {
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            lazy = false,
            build = ":TSUpdate",
            dependencies = {
                { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
            },
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = langs,
                    auto_install = true,
                    highlight = { enable = true },
                    indent = { enable = true },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<C-space>",
                            node_incremental = "<C-space>",
                            node_decremental = "<bs>",
                            scope_incremental = false,
                        },
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                                ["aa"] = "@parameter.outer",
                                ["ia"] = "@parameter.inner",
                            },
                        },
                        move = {
                            enable = true,
                            set_jumps = true,
                            goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
                            goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
                        },
                    },
                })
            end,
        },
    }
end

----------------------------------------------------------------------
-- Neovim 0.12+: main branch (your VM)
-- The rewrite does NOT auto-enable highlighting/indent; we start it per buffer.
----------------------------------------------------------------------
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Install parsers (async; no-op if already present).
            require("nvim-treesitter").install(langs)

            -- Start highlighting + indentation for a buffer.
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

    -- Text objects on the main branch use an explicit setup + keymaps.
    -- Wrapped so a future API tweak can't take highlighting down with it.
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
