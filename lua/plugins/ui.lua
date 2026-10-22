-- ~/.config/nvim/lua/plugins/ui.lua
return {
    -- Colorscheme (swap to "catppuccin", "kanagawa", etc. if you prefer).
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
                lualine_x = {
                    -- "3 cursors" while there are extra cursors on screen
                    -- (multicursor.nvim on 0.12, built-in cursors on 0.13+).
                    {
                        function()
                            local mc = package.loaded["multicursor-nvim"]
                            if mc then
                                return mc.numCursors() .. " cursors" .. (mc.cursorsEnabled() and "" or " (frozen)")
                            end
                            local n = require("core.multicursor").count()
                            return n .. " cursors" .. (vim.bo.follow and "" or " (frozen)")
                        end,
                        cond = function()
                            local mc = package.loaded["multicursor-nvim"]
                            if mc then
                                return mc.hasCursors()
                            end
                            return package.loaded["core.multicursor"] ~= nil and require("core.multicursor").count() > 0
                        end,
                        color = "WarningMsg",
                    },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        },
    },
}
