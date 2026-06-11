-- ~/.config/nvim/lua/plugins/editing.lua
-- Power-editing pack: fast motions, surround, TODO navigation,
-- project-wide search & replace, and session persistence.
return {
    -- Jump anywhere on screen in 2-3 keystrokes. `s` + chars, labels appear.
    -- `S` selects/extends by treesitter nodes. NOTE: this shadows the default
    -- `s` (substitute char) — use `cl` for that, it's identical.
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle flash search" },
        },
    },

    -- Surround on gs* so it never fights flash's `s`:
    --   gsa" (add), gsd" (delete), gsr"' (replace " with '), gsf (find)
    {
        "echasnovski/mini.surround",
        version = false,
        keys = {
            { "gsa", desc = "Add surrounding", mode = { "n", "x" } },
            { "gsd", desc = "Delete surrounding" },
            { "gsf", desc = "Find right surrounding" },
            { "gsF", desc = "Find left surrounding" },
            { "gsh", desc = "Highlight surrounding" },
            { "gsr", desc = "Replace surrounding" },
            { "gsn", desc = "Update n_lines" },
        },
        opts = {
            mappings = {
                add = "gsa",
                delete = "gsd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "gsn",
            },
        },
    },

    -- Highlight + navigate TODO/FIXME/HACK/NOTE comments.
    -- ]t / [t to jump (shadows the rarely-used builtin tag jumps).
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO comment" },
            { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs (Trouble)" },
            -- Lives here (not in snacks.lua) on purpose: pressing it loads
            -- todo-comments first. The explicit registration below is what
            -- todo-comments itself does in setup() — but it defers that until
            -- VimEnter, so we re-assert it (idempotent) for bulletproofing.
            {
                "<leader>ft",
                function()
                    Snacks.picker.sources.todo_comments = require("todo-comments.snacks").source
                    Snacks.picker.todo_comments()
                end,
                desc = "TODO comments (picker)",
            },
        },
    },

    -- Project-wide search & replace with live preview (needs ripgrep).
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        opts = { headerMaxWidth = 80 },
        keys = {
            {
                "<leader>sr",
                function()
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e") or ""
                    require("grug-far").open({
                        transient = true,
                        prefills = { filesFilter = ext ~= "" and "*." .. ext or nil },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search & replace (project)",
            },
            {
                "<leader>sw",
                function()
                    require("grug-far").open({
                        transient = true,
                        prefills = { search = vim.fn.expand("<cword>") },
                    })
                end,
                desc = "Search & replace word under cursor",
            },
        },
    },

    -- Sessions per directory + git branch. `nvim` in a project dir, then
    -- <leader>qs to pick up exactly where you left off.
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (this dir)" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Stop saving this session" },
        },
    },
}
