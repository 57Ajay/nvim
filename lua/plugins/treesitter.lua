-- ~/.config/nvim/lua/plugins/treesitter.lua
--
-- IMPORTANT — read this before changing the branch:
-- The nvim-treesitter `main` rewrite now REQUIRES Neovim 0.12 (nightly) and the
-- repo was frozen/archived in April 2026 as its features move into Neovim core.
-- On stable Neovim 0.11 the working choice is the `master` branch (locked but
-- functional, and what every distro/kickstart still uses on 0.11). When you move
-- to Neovim 0.12, see GUIDE.md for the `main`-branch migration.
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
                ensure_installed = {
                    "lua", "vim", "vimdoc", "query",
                    "go", "gomod", "gosum", "gowork",
                    "typescript", "tsx", "javascript",
                    "rust", "python", "zig",
                    "c", "cpp",
                    "json", "jsonc", "yaml", "toml",
                    "markdown", "markdown_inline",
                    "bash", "html", "css",
                    "diff", "gitcommit", "git_rebase",
                },
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
