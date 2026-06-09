-- ~/.config/nvim/lua/plugins/ui.lua
return {
    -- Colorscheme (swap to "catppuccin", "kanagawa", etc. if you prefer — see GUIDE.md).
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({ style = "night" })
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- Icons (used by lualine, trouble, snacks). Requires a Nerd Font in your terminal.
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                section_separators = "",
                component_separators = "|",
            },
            sections = {
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
            },
        },
    },
}
