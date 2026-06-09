-- ~/.config/nvim/lua/plugins/snacks.lua
-- snacks provides the fast general-purpose picker (everything fff doesn't do:
-- buffers, help, symbols, diagnostics, ...), image previews that fff uses,
-- plus a handful of quality-of-life modules.
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true },
        image = { enabled = true }, -- enables image previews inside fff (Kitty/Wezterm/Ghostty)
        indent = { enabled = true }, -- indent guides + scope highlight
        notifier = { enabled = true }, -- nicer vim.notify
        bigfile = { enabled = true }, -- disable heavy features on huge files
        quickfile = { enabled = true }, -- render a file before plugins load
        input = { enabled = true }, -- nicer vim.ui.input
        words = { enabled = true }, -- highlight references of word under cursor
    },
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
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log (picker)" },
    },
}
