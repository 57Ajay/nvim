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
opt.winborder = "rounded" -- default border for hover/float windows (0.11+)

-- Folding: treesitter-powered, with everything open by default.
-- zc/zo to close/open a fold, za to toggle, zM/zR close/open all.
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldtext = "" -- show the first line of the fold with its normal highlighting

-- Behavior
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen" -- don't shift visible text when opening/closing splits
opt.wrap = true
opt.linebreak = true -- when wrap is on, break at word boundaries, not mid-word
opt.confirm = true -- prompt to save instead of failing :q / :bd on unsaved changes
opt.virtualedit = "block" -- in Visual Block, cursor can move past line ends
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
