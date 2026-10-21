-- ~/.config/nvim/lua/core/cheatsheet.lua
-- <leader>?: fuzzy-search every keybinding documented in KEYBINDINGS.md.
--
-- KEYBINDINGS.md is the single source of truth. Every row of a markdown table
-- whose header has `Key` and `Action` columns (`Mode` and `Keywords` are
-- optional) becomes one entry, searchable by key, action, keywords and the
-- heading it sits under. Document a keymap there and it shows up here.
--
-- In the picker:
--   <CR>                runs the key, if the Key cell is a single `key` and its
--                       Mode includes `n`; otherwise says where the key works
--   <C-s>/<C-v>/<C-t>   open KEYBINDINGS.md at that row instead
local M = {}

M.file = vim.fn.stdpath("config") .. "/KEYBINDINGS.md"

local mode_names = {
    n = "normal",
    v = "visual",
    o = "operator-pending",
    i = "insert",
    c = "command-line",
    t = "terminal",
}

-- Split a markdown table row into trimmed cells (`\|` is a literal pipe).
local function cells(line)
    local ret = {}
    line = line:gsub("\\|", "\1"):gsub("^%s*|", ""):gsub("|%s*$", "")
    for cell in vim.gsplit(line, "|", { plain = true }) do
        ret[#ret + 1] = vim.trim((cell:gsub("\1", "|")))
    end
    return ret
end

-- Markdown to display text: drop code-span backticks and bold markers.
local function plain(text)
    return vim.trim((text:gsub("`", ""):gsub("%*%*", "")))
end

--- Parse KEYBINDINGS.md into picker items.
---@return snacks.picker.finder.Item[]
function M.items()
    local ok, lines = pcall(vim.fn.readfile, M.file)
    if not ok then
        return {}
    end

    local items, section = {}, ""
    local cols -- nil: outside a table · false: a table we skip · table: column index by name
    for lnum, line in ipairs(lines) do
        if not line:find("^%s*|") then
            cols = nil
            local heading = line:match("^##+%s+(.+)")
            section = heading and plain(heading) or section
        elseif cols == nil then -- header row decides which columns hold what
            local idx = {}
            for i, name in ipairs(cells(line)) do
                idx[name:lower()] = i
            end
            cols = idx.key and idx.action and idx or false
        elseif cols and not line:find("^%s*|[%s:|-]*$") then -- skip the |---| row
            local row = cells(line)
            local key = row[cols.key] or ""
            local mode = cols.mode and (row[cols.mode] or ""):gsub("[^%a,]", "") or ""
            local item = {
                key = plain(key),
                mode = mode,
                action = plain(row[cols.action] or ""),
                keywords = cols.keywords and row[cols.keywords] or "",
                section = section,
                -- Tables without a Mode column hold keys that only work inside
                -- one plugin's window: rank them after editing keys on ties.
                rank = cols.mode and 0 or 1,
                file = M.file,
                pos = { lnum, 0 },
            }
            -- Only a lone key used in normal mode can be replayed safely.
            local lhs = key:match("^`([^`]+)`$")
            if lhs and vim.list_contains(vim.split(mode, ","), "n") then
                item.run = lhs
            end
            item.text = table.concat({ item.key, item.action, item.keywords, item.section }, " ")
            if item.key ~= "" then
                items[#items + 1] = item
            end
        end
    end
    return items
end

-- Shown on <CR> for keys that can't be run from the picker.
local function where(item)
    if item.mode == "" then
        return item.section
    end
    local names = vim.tbl_map(function(m)
        return mode_names[m] or m
    end, vim.split(item.mode, ","))
    return "Use it in " .. table.concat(names, " / ") .. " mode"
end

function M.open()
    local items = M.items()
    if #items == 0 then
        vim.notify("No keybindings found in " .. M.file, vim.log.levels.WARN)
        return
    end

    local key_width, mode_width = 0, 0
    for _, item in ipairs(items) do
        key_width = math.max(key_width, vim.api.nvim_strwidth(item.key))
        mode_width = math.max(mode_width, vim.api.nvim_strwidth(item.mode))
    end
    key_width = math.min(key_width, 16) -- don't pad every row for a couple of long ranges

    local align = Snacks.picker.util.align
    Snacks.picker({
        title = "Keybindings",
        items = items,
        layout = { preset = "vertical", layout = { width = 0.8 } }, -- wide list, doc row below
        sort = { fields = { "score:desc", "rank", "#text", "idx" } },
        format = function(item)
            return {
                { align(item.key, key_width), "SnacksPickerKeymapLhs" },
                { " " },
                { align(item.mode, mode_width), "SnacksPickerKeymapMode" },
                { " " },
                { item.action },
                { "  " .. item.section, "SnacksPickerComment" },
            }
        end,
        preview = "file",
        confirm = function(picker, item, action)
            if action and action.cmd then -- <C-s>/<C-v>/<C-t>: show the row in KEYBINDINGS.md
                return Snacks.picker.actions.jump(picker, item, action)
            end
            picker:norm(function()
                picker:close()
                if item and item.run then
                    vim.api.nvim_feedkeys(vim.keycode(item.run), "mt", false)
                elseif item then
                    vim.notify(item.key .. "  " .. item.action .. "\n" .. where(item), vim.log.levels.INFO, {
                        title = "Keybindings",
                    })
                end
            end)
        end,
    })
end

return M
