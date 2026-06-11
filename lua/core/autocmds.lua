-- ~/.config/nvim/lua/core/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("General", { clear = true })

-- Highlight on yank (vim.hl replaces deprecated vim.highlight)
autocmd("TextYankPost", {
    group = general,
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- NOTE: format-on-save is handled by conform.nvim (see lua/plugins/editor.lua),
-- not by an LSP autocmd here. That avoids double-formatting and gives you
-- real formatters (gofmt/goimports, stylua, prettier, rustfmt, zigfmt, ...).

-- Return to last edit position when reopening a file
autocmd("BufReadPost", {
    group = general,
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Auto-create missing parent directories when saving a new file
-- (`:e foo/bar/baz.lua` then `:w` just works)
autocmd("BufWritePre", {
    group = general,
    callback = function(args)
        if args.match:match("^%w+://") then
            return -- skip URL-style buffers (fugitive://, scp://, ...)
        end
        local dir = vim.fn.fnamemodify(args.match, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- Close utility windows with just `q`
autocmd("FileType", {
    group = general,
    pattern = { "help", "man", "qf", "checkhealth", "startuptime" },
    callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, desc = "Close window" })
    end,
})

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
