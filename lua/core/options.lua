-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.winborder = "rounded" -- Neovim 0.11+: default border for hover/float windows

-- Behavior
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.wrap = true -- you had this turned on in init.lua; kept it here
opt.linebreak = true -- when wrap is on, break at word boundaries, not mid-word
opt.backup = false
opt.swapfile = false
opt.undofile = true

-- Performance / UX
opt.updatetime = 300
opt.timeoutlen = 400

-- Diagnostics: keep messages out of the way; details on demand
-- (full diagnostic UI config lives in lua/plugins/lsp.lua)

-- Clipboard
opt.clipboard = "unnamedplus"
