-- ~/.config/nvim/lua/plugins/snacks.lua
-- snacks provides the fast general-purpose picker (everything fff doesn't do:
-- buffers, help, symbols, diagnostics, undo, ...), image previews that fff uses,
-- plus quality-of-life modules and the <leader>u toggle suite.
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true },
        image = { enabled = true }, -- image previews inside fff (Kitty/Wezterm/Ghostty)
        indent = { enabled = true }, -- indent guides + scope highlight
        notifier = { enabled = true }, -- nicer vim.notify
        bigfile = { enabled = true }, -- disable heavy features on huge files
        quickfile = { enabled = true }, -- render a file before plugins load
        input = { enabled = true }, -- nicer vim.ui.input
        words = { enabled = true }, -- highlight references of word under cursor
    },
    config = function(_, opts)
        require("snacks").setup(opts)

        -- <leader>u…: flip UI/editing options on the fly. State shows in which-key.
        Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "relative numbers" }):map("<leader>ur")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
    end,
    keys = {
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
        { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
        { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
        { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
        { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
        { "<leader>f/", function() Snacks.picker.lines() end, desc = "Search in current buffer" },
        { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo history" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log (picker)" },
    },
}
