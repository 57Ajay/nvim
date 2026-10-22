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
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "conceal" }):map("<leader>uc")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "dark background" }):map("<leader>ub")
        Snacks.toggle.zen():map("<leader>uz")
        Snacks.toggle.zoom():map("<leader>uZ")
        -- Format-on-save switches (conform reads these flags; see plugins/editor.lua).
        Snacks.toggle({
            name = "format on save",
            get = function() return not vim.g.disable_autoformat end,
            set = function(state) vim.g.disable_autoformat = not state end,
        }):map("<leader>uf")
        Snacks.toggle({
            name = "format on save (buffer)",
            get = function() return not vim.b.disable_autoformat end,
            set = function(state) vim.b.disable_autoformat = not state end,
        }):map("<leader>uF")
    end,
    keys = {
        -- Searchable list of every keybinding in KEYBINDINGS.md (see lua/core/cheatsheet.lua).
        { "<leader>?", function() require("core.cheatsheet").open() end, desc = "Keybindings cheatsheet (search)" },
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
        { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor" },
        -- (visual: <leader>sg — a visual <leader>fw would make visual <leader>f format wait)
        { "<leader>sg", function() Snacks.picker.grep_word() end, mode = "x", desc = "Grep selection (project)" },
        { "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumplist" },
        { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
        { '<leader>f"', function() Snacks.picker.registers() end, desc = "Registers" },
        { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
        { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification history" },
        { "<leader>fH", function() Snacks.picker.highlights() end, desc = "Highlight groups" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log (picker)" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log (this line)" },
        { "<leader>go", function() Snacks.gitbrowse() end, mode = { "n", "x" }, desc = "Open in browser (GitHub…)" },
        { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "Rename file (LSP-aware)" },

        -- Jump between references of the word under the cursor (snacks.words).
        -- Not ]] / [[: the Go and Python ftplugins claim those per buffer.
        { "]r", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
        { "[r", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference" },

        -- Floating terminal; the same key hides it again. (Many terminals send
        -- <C-/> as <C-_>.) Double <Esc> inside it = normal mode.
        { "<C-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
        { "<C-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "which_key_ignore" },
    },
}
