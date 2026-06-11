-- ~/.config/nvim/lua/core/keymaps.lua
-- Only editor-level keymaps live here. Plugin keymaps live in each plugin spec
-- (so they load lazily and stay discoverable via which-key).
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Window: left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Window: down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Window: up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Window: right" })

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>c", ":bdelete<CR>", { desc = "Close buffer" })

-- Better indenting (keep selection)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selection up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-- Netrw (you like these; kept exactly)
keymap("n", "<leader>e", ":Explore<CR>", { desc = "Netrw: current dir" })
keymap("n", "<leader>HS", ":Hexplore<CR>", { desc = "Netrw: horizontal split" })
keymap("n", "<leader>VS", ":Vexplore<CR>", { desc = "Netrw: vertical split" })
keymap("n", "<leader>nt", ":Texplore<CR>", { desc = "Netrw: new tab" })
keymap("n", "<leader>wl", ":Lexplore<CR>", { desc = "Netrw: toggle left explorer" })

-- Tabs
keymap("n", "L", ":tabn<CR>", { desc = "Next tab" })
for i = 1, 9 do
    keymap("n", "<leader>L" .. i, i .. "gt", { desc = "Go to tab " .. i })
end

-- Diagnostics (non-deprecated API; replaces vim.diagnostic.goto_prev/goto_next)
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
keymap("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })

-- Insert Go error-check block
keymap("n", "<leader>qq", function()
    vim.api.nvim_put({
        "if err != nil {",
        '\tlog.Fatal("some error: ", err)',
        "}",
    }, "l", true, true)
end, { desc = "Insert Go err check" })

-- Insert-mode navigation with Insert key
keymap("i", "<Insert>", "<Right>", { desc = "Move right (insert)" })
keymap("i", "<C-Insert>", "<Down>", { desc = "Move down (insert)" })
