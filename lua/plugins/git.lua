-- ~/.config/nvim/lua/plugins/git.lua
return {
    -- 1) gitsigns: inline signs, hunk staging/preview/reset, blame
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            current_line_blame = false, -- toggle on demand with <leader>gB
            current_line_blame_opts = { delay = 400, virt_text_pos = "eol" },
            on_attach = function(buf)
                local gs = require("gitsigns")
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
                end

                -- Hunk navigation
                map("n", "]h", function() gs.nav_hunk("next") end, "Next git hunk")
                map("n", "[h", function() gs.nav_hunk("prev") end, "Prev git hunk")

                -- Hunk actions (stage_hunk toggles stage/unstage)
                map({ "n", "v" }, "<leader>ga", gs.stage_hunk, "Git stage/unstage hunk")
                map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "Git reset hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Git preview hunk")

                -- Blame
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Git blame line")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Git toggle inline blame")

                -- Text object: select a hunk (e.g. dih / vih)
                map({ "o", "x" }, "ih", gs.select_hunk, "Select git hunk")
            end,
        },
    },

    -- 2) neogit: magit-style interface for staging, committing, pushing, pulling,
    --    branching, stashing, rebasing — all from one buffer.
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit (status/commit/push…)" },
        },
        opts = {
            integrations = { diffview = true },
            graph_style = "unicode",
        },
    },

    -- 3) diffview: real side-by-side diffs, file/branch history, and a 3-way
    --    merge-conflict resolver.
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
        },
        opts = {
            enhanced_diff_hl = true,
            view = {
                -- merge tool layout: LOCAL | MERGED | REMOTE with the base on top
                merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
            },
        },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff: working tree" },
            { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diff: close" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff: this file's history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diff: branch history" },
            { "<leader>gm", "<cmd>DiffviewOpen<cr>", desc = "Diff: resolve merge conflicts" },
        },
    },
}
