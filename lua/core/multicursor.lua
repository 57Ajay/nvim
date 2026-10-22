-- ~/.config/nvim/lua/core/multicursor.lua
-- Neovim 0.13+ has multiple cursors built in (:h multicursor), and
-- multicursor.nvim (lua/plugins/multicursor.lua, used on 0.12) doesn't work
-- with it yet. So on 0.13+ the SAME keys drive the built-in cursors instead.
-- Loaded from core/keymaps.lua only when Neovim has built-in cursors (detected
-- by the 'follow' option, so early 0.13-dev builds without them keep the plugin).
--
-- Built-in model, mapped onto the plugin's: cursors are extmarks in the
-- "nvim.multicursor" namespace. Edits always happen at every cursor; motions
-- only move them all while 'follow' is on — the add-cursor keys below turn it
-- on, <C-q> (= built-in Q) turns it off ("frozen"), <Esc> unfreezes, then clears.
-- What differs from 0.12 is listed in KEYBINDINGS.md → "Multi-cursor on Neovim 0.13+".
local M = {}
local ns = vim.api.nvim_create_namespace("nvim.multicursor")
local keymap = vim.keymap.set

local function cursor_pos()
    local pos = vim.api.nvim_win_get_cursor(0)
    return pos[1] - 1, pos[2]
end

local function has_cursor_at(row, col)
    return #vim.api.nvim_buf_get_extmarks(0, ns, { row, col }, { row, col }, {}) > 0
end

local function has_cursors()
    return #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { limit = 1 }) > 0
end

-- Number of cursors including the main one; 0 when there are no extra cursors.
function M.count()
    local n = #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
    if n == 0 then
        return 0
    end
    return n + (has_cursor_at(cursor_pos()) and 0 or 1)
end

-- Leave a cursor where the main cursor is (no-op if one is already there).
local function drop()
    local row, col = cursor_pos()
    if not has_cursor_at(row, col) then
        vim.api.nvim_buf_set_extmark(0, ns, row, col, {})
    end
end

-- Run a normal-mode command on the main cursor only (with 'follow' off the
-- built-in cursors don't replay it).
local function main_normal(keys)
    local follow = vim.bo.follow
    vim.bo.follow = false
    pcall(vim.cmd, "normal! " .. keys)
    vim.bo.follow = follow
end

-- Lua mappings only act for the main cursor, never once per cursor.
local function main_only(fn)
    return function()
        if not vim.v.cascading then
            fn()
        end
    end
end

-- Keyword under/after the cursor (what `*` would search) and its start column.
local function cword()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        return
    end
    local line, col = vim.api.nvim_get_current_line(), select(2, cursor_pos())
    local init = 1
    while true do
        local s, e = line:find(word, init, true)
        if not s then
            return
        end
        if e > col then
            return word, s - 1
        end
        init = s + 1
    end
end

-- Very-nomagic, case-sensitive pattern for literal text.
local function literal(text, whole_word)
    local pat = vim.fn.escape(text, [[\]]):gsub("\n", [[\n]])
    return whole_word and ([[\C\V\<]] .. pat .. [[\>]]) or ([[\C\V]] .. pat)
end

-- Pattern for the visual selection; leaves Visual mode with the cursor on its start.
local function take_selection()
    local mode, v, c = vim.fn.mode(), vim.fn.getpos("v"), vim.fn.getpos(".")
    local text = table.concat(vim.fn.getregion(v, c, { type = mode }), "\n")
    local first = (v[2] < c[2] or (v[2] == c[2] and v[3] <= c[3])) and v or c
    vim.cmd("normal! \27")
    vim.api.nvim_win_set_cursor(0, { first[2], mode == "V" and 0 or first[3] - 1 })
    local pat = literal(text, false)
    vim.fn.setreg("/", pat) -- so `cgn` / `dgn` change the match at every cursor
    return pat
end

-- Pattern for the word under the cursor; moves the cursor to the word's start.
local function take_word()
    local word, start = cword()
    if not word then
        return
    end
    vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), start })
    return literal(word, true)
end

local function in_visual()
    return vim.fn.mode():match("^[vV\22]") ~= nil
end

-- <C-n> & co: (optionally) leave a cursor on the current match, then move the
-- main cursor to the next/previous match of the word or the selection.
local function match_step(dir, add)
    return main_only(function()
        local pat = in_visual() and take_selection() or take_word()
        if not pat then
            return
        end
        if add then
            drop()
        end
        vim.fn.search(pat, dir > 0 and "w" or "bw")
        vim.bo.follow = true
    end)
end

-- A cursor at every match of `pat` in the buffer.
local function add_all(pat)
    local row, col = cursor_pos()
    for _, m in ipairs(vim.fn.matchbufline("%", pat, 1, "$")) do
        if not (m.lnum - 1 == row and m.byteidx == col) then
            vim.api.nvim_buf_set_extmark(0, ns, m.lnum - 1, m.byteidx, {})
        end
    end
    vim.bo.follow = true
end

-- `ga{motion}`: a cursor on every line of the motion, at the cursor's column.
function M.lines_operator()
    if vim.v.cascading then
        return
    end
    local row, col = vim.fn.line("."), M.ga_col or 0
    for lnum = vim.fn.line("'["), vim.fn.line("']") do
        local c = math.min(col, math.max(#vim.fn.getline(lnum) - 1, 0))
        if lnum == row then
            vim.api.nvim_win_set_cursor(0, { lnum, c })
        elseif not has_cursor_at(lnum - 1, c) then
            vim.api.nvim_buf_set_extmark(0, ns, lnum - 1, c, {})
        end
    end
    vim.bo.follow = true
end

-- Add a cursor here, then move the main cursor one line down/up.
local function line_step(key)
    return main_only(function()
        drop()
        main_normal(key)
        vim.bo.follow = true
    end)
end

-- With cursors: make the next/previous one the main one, keeping one where you
-- were. Without: the usual ]c / [c (next/previous change in diff mode).
local function rotate(key, native)
    return main_only(function()
        if not has_cursors() then
            return main_normal(vim.v.count1 .. native)
        end
        drop()
        main_normal(key)
    end)
end

local nx = { "n", "x" }

keymap(nx, "<C-n>", match_step(1, true), { desc = "Multicursor: add at next match" })
keymap(nx, "<leader>mn", match_step(1, true), { desc = "Add cursor at next match" })
keymap(nx, "<leader>mN", match_step(-1, true), { desc = "Add cursor at previous match" })
keymap(nx, "<leader>ms", match_step(1, false), { desc = "Skip to next match (no cursor)" })
keymap(nx, "<leader>mS", match_step(-1, false), { desc = "Skip to previous match" })
keymap(nx, "<leader>ma", main_only(function()
    local pat = in_visual() and take_selection() or take_word()
    if pat then
        add_all(pat)
    end
end), { desc = "Add cursors at ALL matches" })

keymap("n", "<A-J>", line_step("j"), { desc = "Multicursor: add on line below" })
keymap("n", "<A-K>", line_step("k"), { desc = "Multicursor: add on line above" })
keymap("n", "<leader>mj", line_step("j"), { desc = "Add cursor on line below" })
keymap("n", "<leader>mk", line_step("k"), { desc = "Add cursor on line above" })
keymap("n", "ga", function()
    M.ga_col = vim.fn.col(".") - 1
    vim.o.operatorfunc = "v:lua.require'core.multicursor'.lines_operator"
    return "g@"
end, { expr = true, desc = "Add cursor on every line of motion" })
keymap("x", "ga", "Q", { desc = "Add cursor on every selected line" })
-- Visual I/A: a cursor per selected line, then insert/append (block mode: as usual).
keymap("x", "I", function() return vim.fn.mode() == "\22" and "I" or "QI" end,
    { expr = true, desc = "Insert at start of every selected line" })
keymap("x", "A", function() return vim.fn.mode() == "\22" and "A" or "QA" end,
    { expr = true, desc = "Append at end of every selected line" })

keymap("n", "<leader>m/", main_only(function() add_all(vim.fn.getreg("/")) end),
    { desc = "Add cursors at all /search matches" })
keymap("x", "<leader>m/", "zq/", { desc = "Add cursors at regex matches in selection" })
keymap(nx, "<leader>mm", "zq", { desc = "Cursor at every target of a motion (zq)" })

keymap("n", "<C-q>", "Q", { desc = "Multicursor: toggle cursor here (freeze)" })
keymap("n", "<leader>mc", "Q", { desc = "Toggle cursor here (freezes others)" })
keymap("n", "<leader>md", "2Q", { desc = "Remove the cursor under the main cursor" })
keymap("n", "<leader>mr", "gQ", { desc = "Restore cleared cursors" })
keymap("n", "]c", rotate("]C", "]c"), { desc = "Next cursor / next change (diff)" })
keymap("n", "[c", rotate("[C", "[c"), { desc = "Previous cursor / previous change (diff)" })

-- <Esc>: unfreeze the cursors if frozen, otherwise back to one cursor (the
-- built-in way to clear is <C-l>, but that is window navigation here).
keymap("n", "<Esc>", main_only(function()
    if not has_cursors() then
        return vim.cmd("nohlsearch")
    end
    if not vim.bo.follow then
        vim.bo.follow = true
    else
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
end), { desc = "Clear cursors / search highlights" })

return M
