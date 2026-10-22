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
keymap("n", "<leader>wa", "<cmd>wall<CR>", { desc = "Save all buffers" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Quit all (asks to save)" })
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })
-- <Esc> in normal mode also clears search highlights. (With multiple cursors
-- on screen it clears the cursors instead: plugins/multicursor.lua on 0.12,
-- core/multicursor.lua on 0.13+.)
keymap("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlights" })

-- j/k move by screen line on wrapped text, but by real line with a count
-- (so `5j` with relative numbers still lands where the number says).
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (wrap-aware)" })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Replace the word under the cursor in the whole buffer (edit, then <CR>)
keymap("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word (buffer)" })

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

-- Tabs. (`L` is the same key as <S-l>, so mapping it to :tabn silently
-- killed "next buffer" above. Next/prev tab is the built-in gt / gT.)
for i = 1, 9 do
    keymap("n", "<leader>L" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
keymap("n", "<leader>Ln", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>Lc", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>Lo", "<cmd>tabonly<CR>", { desc = "Close other tabs" })

-- Diagnostics (non-deprecated API; replaces vim.diagnostic.goto_prev/goto_next)
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
keymap("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
local function jump_severity(count, severity)
    return function()
        vim.diagnostic.jump({ count = count, severity = vim.diagnostic.severity[severity], float = true })
    end
end
keymap("n", "]e", jump_severity(1, "ERROR"), { desc = "Next error" })
keymap("n", "[e", jump_severity(-1, "ERROR"), { desc = "Prev error" })
keymap("n", "]w", jump_severity(1, "WARN"), { desc = "Next warning" })
keymap("n", "[w", jump_severity(-1, "WARN"), { desc = "Prev warning" })

-- Inspect what's under the cursor (highlight groups / treesitter nodes)
keymap("n", "<leader>ui", vim.show_pos, { desc = "Inspect highlight under cursor" })
keymap("n", "<leader>uI", "<cmd>InspectTree<CR>", { desc = "Inspect syntax tree" })

-- Insert Go error-check block
keymap("n", "<leader>qq", function()
    vim.api.nvim_put({
        "if err != nil {",
        '\tlog.Fatal("some error: ", err)',
        "}",
    }, "l", true, true)
end, { desc = "Insert Go err check" })

-- Insert-mode navigation with Insert key. <C-g>U keeps the edit in one piece,
-- so `.` and undo (and multi-cursor typing, which replays with `.`) still
-- cover the whole insert instead of only the part after the jump.
keymap("i", "<Insert>", "<C-g>U<Right>", { desc = "Move right (insert)" })
keymap("i", "<C-Insert>", "<Down>", { desc = "Move down (insert)" })

-- Multi-cursor: Neovim 0.13+ has it built in (such builds have the 'follow'
-- option); the same keys drive it there. Otherwise the multicursor.nvim plugin
-- provides them (plugins/multicursor.lua).
if vim.fn.exists("+follow") == 1 then
    require("core.multicursor")
end
