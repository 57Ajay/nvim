-- ~/.config/nvim/lua/plugins/fff.lua
-- The "freakin fast fuzzy file finder": Rust-backed file picker + live grep.
-- Tracks a file index, your access frecency, and git status for ranked results.
return {
    "dmtrKovalenko/fff.nvim",
    -- Downloads a prebuilt binary, or builds from source with your Rust toolchain.
    build = function()
        require("fff.download").download_or_build_binary()
    end,
    lazy = false, -- it self-initializes lazily; the picker only opens when invoked
    opts = {}, -- works great out of the box; see :h fff for options
    keys = {
        { "<leader>ff", function() require("fff").find_files() end, desc = "Find files (fff)" },
        { "<leader>fg", function() require("fff").live_grep() end, desc = "Live grep (fff)" },
        {
            "<leader>fz",
            function() require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } }) end,
            desc = "Fuzzy grep (fff)",
        },
    },
}
