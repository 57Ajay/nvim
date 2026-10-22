-- ~/.config/nvim/lua/plugins/multicursor.lua
-- Multiple cursors that behave like plain Vim: add cursors, then use ANY
-- normal command (motions, operators, text objects, insert, `.`, macros, undo)
-- and it runs at every cursor. <Esc> collapses back to one cursor.
--
-- Quick start (full guide + tutorial in KEYBINDINGS.md → "Multi-cursor"):
--   <C-n>          on a word: each press adds a cursor on the next match
--   <A-J> / <A-K>  add a cursor on the line below / above (Alt+Shift+j/k)
--   V…j  then I/A  type at the start / end of every selected line
--   …then edit normally (ciw, A;, dw, …) and <Esc> when done.
--
-- No action needs the arrow keys. Everything is also under <leader>m
-- (which-key lists it). A few keys exist only while extra cursors are on
-- screen — see the keymap layer at the bottom.
--
-- Neovim 0.13+ has multiple cursors built in, and this plugin doesn't work
-- with them yet, so there it stays installed but unloaded and the same keys
-- drive the built-in cursors instead (lua/core/multicursor.lua).

-- Call a multicursor action lazily, e.g. action("lineAddCursor", 1).
-- If a key lands while the previous action is still running (key repeat on
-- <C-n>, macros), the plugin errors "An action is already being performed";
-- such a press is queued to run right after instead.
local function action(name, ...)
    local args = { ... }
    local function run()
        require("multicursor-nvim")[name](unpack(args))
    end
    return function()
        local core = package.loaded["multicursor-nvim.core"]
        if core and core.performingAction then
            vim.schedule(run)
        else
            run()
        end
    end
end

return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    -- Builds with built-in cursors (0.13+) have the 'follow' option.
    cond = vim.fn.exists("+follow") == 0,
    event = "VeryLazy",
    keys = {
        -- Add cursors by matching the word under the cursor (or the selection)
        { "<C-n>", action("matchAddCursor", 1), mode = { "n", "x" }, desc = "Multicursor: add at next match" },
        { "<leader>mn", action("matchAddCursor", 1), mode = { "n", "x" }, desc = "Add cursor at next match" },
        { "<leader>mN", action("matchAddCursor", -1), mode = { "n", "x" }, desc = "Add cursor at previous match" },
        { "<leader>ms", action("matchSkipCursor", 1), mode = { "n", "x" }, desc = "Skip to next match (no cursor)" },
        { "<leader>mS", action("matchSkipCursor", -1), mode = { "n", "x" }, desc = "Skip to previous match" },
        { "<leader>ma", action("matchAllAddCursors"), mode = { "n", "x" }, desc = "Add cursors at ALL matches" },

        -- Add cursors line by line (column editing)
        { "<A-J>", action("lineAddCursor", 1), mode = { "n", "x" }, desc = "Multicursor: add on line below" },
        { "<A-K>", action("lineAddCursor", -1), mode = { "n", "x" }, desc = "Multicursor: add on line above" },
        { "<leader>mj", action("lineAddCursor", 1), mode = { "n", "x" }, desc = "Add cursor on line below" },
        { "<leader>mk", action("lineAddCursor", -1), mode = { "n", "x" }, desc = "Add cursor on line above" },
        { "ga", action("addCursorOperator"), mode = { "n", "x" }, desc = "Add cursor on every line of motion" },
        { "I", action("insertVisual"), mode = "x", desc = "Insert at start of every selected line" },
        { "A", action("appendVisual"), mode = "x", desc = "Append at end of every selected line" },

        -- Add cursors from a search or a regex
        { "<leader>m/", action("searchAllAddCursors"), desc = "Add cursors at all /search matches" },
        { "<leader>m/", action("matchCursors"), mode = "x", desc = "Add cursors at regex matches in selection" },
        { "<leader>m|", action("splitCursors"), mode = "x", desc = "Split selection by regex" },
        { "<leader>mm", action("operator"), mode = { "n", "x" }, desc = "Match text inside a range (iw, then ip)" },

        -- Place and manage cursors
        { "<C-q>", action("toggleCursor"), mode = { "n", "x" }, desc = "Multicursor: toggle cursor here (freeze)" },
        { "<leader>mc", action("toggleCursor"), mode = { "n", "x" }, desc = "Toggle cursor here (freezes others)" },
        { "<leader>md", action("deleteCursor"), mode = { "n", "x" }, desc = "Delete main cursor" },
        { "<leader>mr", action("restoreCursors"), desc = "Restore cleared cursors" },
        { "<leader>m=", action("alignCursors"), desc = "Align cursor columns" },
        { "<leader>mt", action("transposeCursors", 1), mode = "x", desc = "Rotate selections forward" },
        { "<leader>mT", action("transposeCursors", -1), mode = "x", desc = "Rotate selections backward" },

        -- Mouse: Ctrl+click adds/removes a cursor, Ctrl+drag adds several
        { "<C-LeftMouse>", action("handleMouse"), desc = "Multicursor: add/remove at click" },
        { "<C-LeftDrag>", action("handleMouseDrag"), desc = "Multicursor: add by dragging" },
        { "<C-LeftRelease>", action("handleMouseRelease"), desc = "Multicursor: finish mouse add" },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        -- Keymap layer: these exist only while extra cursors are on screen,
        -- so they never steal the keys from normal editing.
        mc.addKeymapLayer(function(set)
            -- Choose which cursor is the "main" one (the one the screen follows).
            set({ "n", "x" }, "]c", action("nextCursor"), { desc = "Next cursor" })
            set({ "n", "x" }, "[c", action("prevCursor"), { desc = "Previous cursor" })
            set({ "n", "x" }, "<Right>", action("nextCursor"), { desc = "Next cursor" })
            set({ "n", "x" }, "<Left>", action("prevCursor"), { desc = "Previous cursor" })

            -- Number the cursors 1, 2, 3… instead of adding the same amount everywhere.
            set({ "n", "x" }, "g<C-a>", action("sequenceIncrement"), { desc = "Increment as a sequence" })
            set({ "n", "x" }, "g<C-x>", action("sequenceDecrement"), { desc = "Decrement as a sequence" })

            -- <Esc>: unfreeze the cursors if they're frozen, otherwise back to one.
            set("n", "<Esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end, { desc = "Unfreeze / clear cursors" })
        end)
    end,
}
