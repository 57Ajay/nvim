# Keybindings

Every key this config adds, plus the Neovim and plugin defaults you need to get
around, grouped by what you're trying to do. Each row has **keywords**, so you
can search for the task instead of the key.

**Find a key fast**

- **Inside Neovim:** press `<Space>?` and type what you want to do (`save`,
  `rename`, `breakpoint`, `commit`, `split`…). <kbd>Enter</kbd> runs the
  highlighted key for you.
- **In this file:** <kbd>Ctrl</kbd>+<kbd>F</kbd> for a keyword.
- **Forgot how a sequence continues?** Press `<Space>` (or `g`, `[`, `]`…) and
  wait. which-key pops up with everything that can follow.
- **New:** multiple cursors — see [Multi-cursor](#multi-cursor) (`<C-n>`,
  `<A-J>`/`<A-K>`, visual `I`/`A`). What else changed is in
  [What's new](#whats-new).

## How to read the tables

| Notation | Meaning |
| --- | --- |
| `<leader>` | <kbd>Space</kbd>. `<leader>ff` means press Space, then `f`, then `f` |
| `<localleader>` | Also <kbd>Space</kbd> (used inside some plugin windows) |
| `<C-x>` · `<A-x>` · `<S-x>` | Ctrl+x · Alt+x · Shift+x |
| `H`, `L`, `S`… | A capital letter means Shift + that letter |
| `<CR>` · `<Esc>` · `<BS>` · `<Tab>` | Enter · Escape · Backspace · Tab |
| Mode `n` · `v` · `o` | Normal · visual · operator-pending (right after an operator such as `d`, `y`, `c`) |
| Mode `i` · `c` · `t` | Insert · command line (`:` or `/`) · terminal |

Rows marked **(LSP)** only work once a language server is attached to the
buffer; **(git)** rows only in files tracked by git. **(built-in)** marks
Neovim's own keys that are worth knowing.

## Contents

- [Help & discovery](#help--discovery)
- [Save, quit & sessions](#save-quit--sessions)
- [Windows, buffers & tabs](#windows-buffers--tabs)
- [File explorer (netrw)](#file-explorer-netrw)
- [Find files & text](#find-files--text)
- [Search & replace](#search--replace)
- [Code intelligence (LSP)](#code-intelligence-lsp)
- [Diagnostics & lists](#diagnostics--lists)
- [Editing](#editing)
- [Multi-cursor](#multi-cursor)
- [Insert mode, completion & command line](#insert-mode-completion--command-line)
- [Motions (flash)](#motions-flash)
- [Surround](#surround)
- [Text objects & code navigation](#text-objects--code-navigation)
- [Folds](#folds)
- [TODO comments](#todo-comments)
- [Git](#git)
- [Debugging (DAP)](#debugging-dap)
- [Testing (neotest)](#testing-neotest)
- [UI toggles](#ui-toggles)
- [Terminal & tools](#terminal--tools)
- [Inside pickers](#inside-pickers)
- [Inside other windows](#inside-other-windows)
- [Vim defaults this config changes](#vim-defaults-this-config-changes)
- [What's new](#whats-new)
- [Adding or changing a keybinding](#adding-or-changing-a-keybinding)

## Help & discovery

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>?` | n | Search every keybinding in this file; Enter runs the key | cheatsheet, help, keymaps, shortcuts, list, discover, search keys |
| `<leader>` | n | Press and wait: which-key shows every key that can follow | which-key, popup, menu, hints, leader, space |
| `<leader>fk` | n | Search every active keymap, including Neovim and plugin defaults | keymaps, mappings, all keys, defaults, live |
| `<leader>fh` | n | Search Neovim's help pages | help, docs, documentation, manual, vimdoc |
| `<leader>fc` | n | Search and run commands | commands, command palette, ex, run command |

## Save, quit & sessions

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>w` | n | Save the file | save, write, file, store |
| `<leader>wa` | n | Save every changed buffer | save all, write all, wall |
| `<leader>q` | n | Quit the window (asks before dropping unsaved changes) | quit, exit, close window, leave |
| `<leader>qa` | n | Quit Neovim (asks before dropping unsaved changes) | quit all, exit, qa, close everything |
| `<leader>qs` | n | Restore the session for this directory and git branch | session, restore, resume, reopen, persistence |
| `<leader>ql` | n | Restore the last session | session, last, restore, resume |
| `<leader>qd` | n | Don't save the current session on exit | session, stop, disable, forget |

`<leader>w`, `<leader>q` and `<leader>c` are also the first keys of longer
sequences (`<leader>wl`/`wa`, `<leader>qq`/`qa`/`qs`/`ql`/`qd`, and `<leader>ca` in LSP
buffers), so Neovim waits `timeoutlen` (400 ms) to see if you keep typing
before it saves, quits or closes. That short pause is expected. `<leader>f`
(format) works the same way.

## Windows, buffers & tabs

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<C-h>` | n | Move to the window on the left | window, split, focus, navigate, pane, left |
| `<C-j>` | n | Move to the window below | window, split, focus, navigate, pane, down |
| `<C-k>` | n | Move to the window above | window, split, focus, navigate, pane, up |
| `<C-l>` | n | Move to the window on the right (inside netrw `<C-l>` refreshes the listing; use `<C-w>l`) | window, split, focus, navigate, pane, right |
| `<C-Up>` | n | Make the window shorter | resize, height, smaller, window, split |
| `<C-Down>` | n | Make the window taller | resize, height, bigger, window, split |
| `<C-Left>` | n | Make the window narrower | resize, width, smaller, window, vertical |
| `<C-Right>` | n | Make the window wider | resize, width, bigger, window, vertical |
| `<C-w>v` | n | Split the window vertically (built-in) | split, vsplit, vertical, side by side, new window |
| `<C-w>s` | n | Split the window horizontally (built-in) | split, horizontal, new window |
| `<C-w>q` | n | Close the window (built-in) | close window, quit split |
| `<C-w>o` | n | Close every other window (built-in) | only, close others, maximize |
| `<C-w>=` | n | Make all windows the same size (built-in) | equalize, balance, resize |
| `H` | n | Previous buffer | buffer, previous, back, switch, cycle, shift h |
| `]b` | n | Next buffer (built-in) | buffer, next, forward, switch, cycle |
| `[b` | n | Previous buffer (built-in) | buffer, previous, back, switch, cycle |
| `<leader>c` | n | Close (delete) the current buffer | close buffer, delete buffer, bdelete, kill |
| `L` | n | Next tab | tab, next, tabnext, switch, shift l |
| `gT` | n | Previous tab (built-in) | tab, previous, tabprevious |
| `<leader>L1` … `<leader>L9` | n | Go to tab 1 … 9 | tab, jump, number, go to tab |
| `<leader>Ln` | n | Open a new tab | new tab, tabnew, create tab |
| `<leader>Lc` | n | Close the tab | close tab, tabclose |
| `<leader>Lo` | n | Close every other tab | only tab, tabonly, close others |

Next buffer is `]b`: `<S-l>` is the same key as `L`, which is *next tab*
(the dead `<S-l>` = next buffer mapping was removed). To maximise a window
temporarily, use `<leader>uZ` (zoom).

## File explorer (netrw)

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>e` | n | Open netrw in the current file's folder | explorer, file tree, files, browse, folder, netrw |
| `<leader>wl` | n | Toggle a netrw sidebar on the left | explorer, sidebar, tree, lexplore, toggle, side panel |
| `<leader>HS` | n | Open netrw in a horizontal split | explorer, split, hexplore |
| `<leader>VS` | n | Open netrw in a vertical split | explorer, vsplit, vexplore |
| `<leader>nt` | n | Open netrw in a new tab | explorer, tab, texplore |

### Inside netrw

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Open the file or folder | open, enter, edit |
| `-` | Go up to the parent folder | parent, up, back, directory |
| `%` | Create a new file | new file, create, touch |
| `d` | Create a new folder | mkdir, new folder, directory |
| `D` | Delete the file or folder | delete, remove, rm |
| `R` | Rename or move | rename, move, mv |
| `v` · `o` · `t` | Open in a vertical split · horizontal split · new tab | split, vsplit, tab, open |
| `p` | Preview the file | preview, peek |
| `gh` | Show / hide dotfiles | hidden files, dotfiles, toggle |
| `i` | Cycle the listing style (thin, long, wide, tree) | view, tree, list style |
| `mf` · `mt` · `mc` · `mm` | Mark file · mark target folder · copy marked there · move marked there | mark, copy, move, multiple files |
| `<C-l>` | Refresh the listing | refresh, reload |
| `x` | Open with the system's default app | open external, xdg-open |

## Find files & text

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>ff` | n | Find files by name (fff, ranked by frecency and git status) | find file, open file, quick open, ctrl+p, fuzzy, files, project, fff |
| `<leader>fg` | n | Live grep: search text in every file (fff) | grep, search text, find in files, ctrl+shift+f, ripgrep, project |
| `<leader>fz` | n | Fuzzy grep: typo-tolerant text search (fff) | grep, fuzzy, search text, approximate, typo |
| `<leader>fr` | n | Recent files | recent, history, oldfiles, mru, reopen |
| `<leader>fb` | n | Open buffers | buffers, switch, open files, tabs |
| `<leader>f/` | n | Search lines in the current buffer | search, lines, buffer, current file, find in file |
| `<leader>fs` | n | Symbols in this file (LSP) | symbols, outline, functions, methods, document, go to symbol |
| `<leader>fS` | n | Symbols in the whole workspace (LSP) | symbols, workspace, project, go to symbol |
| `<leader>fd` | n | Diagnostics in the project | diagnostics, errors, warnings, problems |
| `<leader>fu` | n | Undo history: browse and restore old versions | undo, history, undotree, revert, time travel |
| `<leader>fR` | n | Resume the last picker | resume, last, reopen, picker, again |
| `<leader>fw` | n | Grep the word under the cursor in the project (for a selection: `<leader>sg`) | grep word, cword, find usages text, search word |
| `<leader>fj` | n | Jumplist | jumps, jumplist, back, history, ctrl-o |
| `<leader>fm` | n | Marks | marks, bookmarks |
| `<leader>f"` | n | Registers (paste one with `<CR>`) | registers, clipboard history, yank history, paste |
| `<leader>fq` | n | Quickfix list (picker) | quickfix, qflist |
| `<leader>fn` | n | Notification history — missed a message? it's here | notifications, messages, history, errors, log |
| `<leader>fH` | n | Highlight groups | highlights, colors, theme, hl groups |

## Search & replace

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>h` | n | Clear search highlighting | nohlsearch, clear highlight, unhighlight, search |
| `<Esc>` | n | Also clears search highlighting (with extra cursors on screen it clears those instead) | nohlsearch, clear highlight, escape |
| `<leader>ss` | n | Substitute the word under the cursor in this buffer: `:%s/\<word\>/word/gI` opens with the cursor on the replacement — edit it, `<CR>` | substitute, replace word, rename text, sed, s command |
| `<leader>sg` | v | Grep the selected text in the project | grep selection, search selection, find text |
| `<leader>sr` | n, v | Search & replace across the project (grug-far). Files filter starts as this file's type; in visual mode the selection becomes the search | search replace, find and replace, refactor, project, grug-far, substitute |
| `<leader>sw` | n | Search & replace the word under the cursor (grug-far) | replace word, search replace, cword, rename text |

### Inside grug-far

| Key | Action | Keywords |
| --- | --- | --- |
| `<Tab>` · `<S-Tab>` | Next · previous input (Search, Replace, Files Filter, Flags, Paths) | fields, inputs, next field |
| `<localleader>r` | Replace every match (Space, then `r`) | replace all, apply, execute, run |
| `<localleader>s` | Write edits you made in the results list back to the files | sync, apply edits, write |
| `<CR>` | Go to the match under the cursor | open, jump, goto |
| `<localleader>q` | Send the results to the quickfix list | quickfix, list |
| `<localleader>c` | Close grug-far | close, quit |
| `g?` | Show every grug-far key | help |

## Code intelligence (LSP)

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `gd` | n | Go to definition (LSP) | definition, jump, goto, navigate, source |
| `gD` | n | Go to declaration (LSP) | declaration, header, goto |
| `gr` | n | List references (LSP); instant | references, usages, callers, find usages |
| `gi` | n | Go to implementation (LSP) | implementation, interface, goto |
| `gt` | n | Go to type definition (LSP); in LSP buffers this replaces Vim's next-tab `gt`, use `L` | type, type definition, goto |
| `K` | n | Hover documentation (LSP); press again to move into it | hover, docs, documentation, info, type info |
| `gK` | n | Show the function signature (LSP) | signature, parameters, arguments, help |
| `]r` | n | Next reference of the symbol under the cursor (LSP) | next reference, usage, occurrence, jump |
| `[r` | n | Previous reference of the symbol under the cursor (LSP) | previous reference, usage, occurrence, jump |
| `<leader>rn` | n | Rename the symbol everywhere (LSP) | rename, refactor, symbol, variable |
| `<leader>rf` | n | Rename the current file; the LSP updates imports | rename file, move file, mv |
| `<leader>ca` | n, v | Code actions and quick fixes (LSP); in visual mode for the selection, e.g. "extract function" | code action, quick fix, lightbulb, import, refactor, extract |
| `<leader>f` | n, v | Format the buffer or selection (conform; also runs on save) | format, prettier, beautify, indent, style, stylua, gofmt |
| `<C-s>` | i | Show the function signature while typing (built-in) | signature, parameters, arguments, help |
| `gra` | v | Code action for the selection (built-in LSP key) | code action, quick fix |
| `gO` | n | Document symbols in the location list (built-in LSP key) | symbols, outline |

`gr` is set to `nowait`, so it fires at once instead of pausing `timeoutlen`
for Neovim's own `grn` `grr` `gri` `grt` `grx` (which also start with `gr`).
The price: those can't be typed in LSP buffers. They only duplicate
`<leader>rn`, `gr`, `gi`, `gt` and `<leader>ca`.

## Diagnostics & lists

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `]d` | n | Next diagnostic, with its message in a float | diagnostic, error, warning, problem, next |
| `[d` | n | Previous diagnostic, with its message in a float | diagnostic, error, warning, problem, previous |
| `]D` | n | Last diagnostic in the buffer (built-in) | diagnostic, last |
| `[D` | n | First diagnostic in the buffer (built-in) | diagnostic, first |
| `]e` | n | Next error (skips warnings and hints) | error, next error, problem, severity |
| `[e` | n | Previous error | error, previous error, problem, severity |
| `]w` | n | Next warning | warning, next warning, severity |
| `[w` | n | Previous warning | warning, previous warning, severity |
| `<leader>xd` | n | Show the diagnostic under the cursor in a float | diagnostic, float, message, error, show, explain |
| `<C-w>d` | n | Same as `<leader>xd` (built-in) | diagnostic, float |
| `<leader>xx` | n | Project diagnostics list (Trouble) | diagnostics, trouble, errors, problems, workspace |
| `<leader>xX` | n | Diagnostics list for this buffer (Trouble) | diagnostics, buffer, current file, trouble |
| `<leader>xs` | n | Symbols outline (Trouble) | symbols, outline, structure, trouble |
| `<leader>xq` | n | Quickfix list (Trouble) | quickfix, qflist, trouble |
| `<leader>xl` | n | Location list (Trouble) | loclist, location list, trouble |
| `]q` | n | Next quickfix item (built-in) | quickfix, next, cnext |
| `[q` | n | Previous quickfix item (built-in) | quickfix, previous, cprev |

### Inside Trouble

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Jump to the item | open, jump, goto |
| `o` | Jump to the item and close Trouble | open, jump, close |
| `p` | Preview the item | preview |
| `<C-s>` · `<C-v>` | Open in a split · vertical split | split, vsplit |
| `q` | Close | close, quit |
| `?` | Show every Trouble key | help |

## Editing

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<` | v | Indent left and keep the selection | indent, outdent, unindent, shift left |
| `>` | v | Indent right and keep the selection | indent, shift right |
| `J` | v | Move the selection down | move, lines, drag, down |
| `K` | v | Move the selection up | move, lines, drag, up |
| `<A-j>` | n, v | Move the line or selection down | move line, drag, swap, down, alt |
| `<A-k>` | n, v | Move the line or selection up | move line, drag, swap, up, alt |
| `gcc` | n | Toggle comment on the line (built-in) | comment, uncomment, toggle comment, line |
| `gc` | n, v | Toggle comment over a motion or selection, e.g. `gcip` (built-in) | comment, uncomment, block, paragraph |
| `]<Space>` | n | Add an empty line below (built-in) | blank line, empty line, newline, below |
| `[<Space>` | n | Add an empty line above (built-in) | blank line, empty line, newline, above |
| `<leader>qq` | n | Insert a Go `if err != nil { log.Fatal(…) }` block below the line | go, golang, error, err, snippet, iferr |
| `j` · `k` | n, v | Move by screen line on wrapped text; with a count (`5j`) by real lines | wrap, wrapped lines, gj, gk, down, up |
| `P` | v | Paste over the selection without losing what you yanked (built-in) | paste, replace selection, keep register |
| `.` | n | Repeat the last change (built-in) | repeat, dot, again |

## Multi-cursor

Add cursors, then edit exactly like normal Vim: every operator, text object,
insert, `.` repeat, paste, macro, `>>`, `gU`, `r` … runs at **every** cursor,
and motions (`w`, `e`, `f(`, `$` …) move them all together. `<Esc>` in normal
mode goes back to one cursor, and a single `u` undoes the edit everywhere.
Nothing here needs the arrow keys. While there are extra cursors the
statusline shows **N cursors**; the cursor the screen follows is the *main*
one, and the newest cursor you add becomes the main one.

Neovim 0.12 gets this from the
[multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) plugin.
Neovim 0.13+ has multiple cursors built in, and there the **same keys** drive
the built-in cursors (the plugin isn't compatible with them yet) — see
[Multi-cursor on Neovim 0.13+](#multi-cursor-on-neovim-013).

```
<C-n> <C-n> <C-n>     on a word: a cursor on each next match  (VS Code's Ctrl+D)
ciw new <Esc> <Esc>   change all of them, then back to one cursor
<A-J> <A-J>           a cursor on the next two lines           (Alt+Shift+j)
V j j  I # <Esc>      type "#" in front of every selected line
```

### Adding cursors

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<C-n>` | n, v | Add a cursor at the next match of the word under the cursor (or of the selection); press again for more | multi cursor, multicursor, multiple cursors, next match, occurrence, select next, ctrl+d, vscode |
| `<leader>mn` | n, v | Same as `<C-n>` | multi cursor, next match, occurrence |
| `<leader>mN` | n, v | Add a cursor at the previous match | multi cursor, previous match, occurrence |
| `<leader>ms` | n, v | Skip this match: jump to the next one without keeping a cursor here | multi cursor, skip, unwanted match |
| `<leader>mS` | n, v | Skip backwards | multi cursor, skip, previous |
| `<leader>ma` | n, v | A cursor on every match in the file | multi cursor, all matches, all occurrences, select all, ctrl+shift+l |
| `<A-J>` | n | Add a cursor on the line below (Alt+Shift+j); 0.12: also in visual mode | multi cursor, column, vertical, line below, down, alt |
| `<A-K>` | n | Add a cursor on the line above (Alt+Shift+k); 0.12: also in visual mode | multi cursor, column, vertical, line above, up, alt |
| `<leader>mj` · `<leader>mk` | n | Same as `<A-J>` · `<A-K>`, for terminals without Alt | multi cursor, line below, line above |
| `ga` | n, v | A cursor on every line of a motion — `gaip` the paragraph, `ga4j` this and 4 more lines; in visual mode every selected line | multi cursor, every line, paragraph, lines, operator |
| `I` | v | Insert at the start of every selected line (block mode: as usual) | multi cursor, prefix lines, start of line, column insert |
| `A` | v | Append at the end of every selected line (block mode: as usual) | multi cursor, suffix lines, end of line, column append |
| `<leader>m/` | n | A cursor on every match of the last `/` search | multi cursor, search, regex, pattern, all matches |
| `<leader>m/` | v | A cursor on every regex match inside the selection (asks for the regex) | multi cursor, regex, inside selection |
| `<leader>m\|` | v | Split the selection by a regex (asks for it); 0.12 only | multi cursor, split, separator |
| `<leader>mm` | n, v | 0.12: every match of a text object inside a range (`<leader>mm iw af`); 0.13+: built-in `zq{motion}` | multi cursor, inside function, range, operator, zq |
| `<C-q>` | n | Add (or remove) a cursor here and freeze the others, so you can walk to the next spot; 0.12: also in visual mode | multi cursor, place cursor, toggle, freeze, anywhere |
| `<leader>mc` | n | Same as `<C-q>` | multi cursor, place cursor, toggle |
| Ctrl+click | n | Add or remove a cursor with the mouse (0.12: Ctrl+drag adds several) | multi cursor, mouse, click, ctrl+click, c-leftmouse |
| `<leader>mr` | n | Restore the cursors you just cleared | multi cursor, restore, bring back, undo clear |

### While there are extra cursors

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<Esc>` | n | Unfreeze the cursors if frozen, otherwise back to one cursor | multi cursor, clear cursors, exit, collapse, done |
| `]c` · `[c` | n | Make the next · previous cursor the main one (0.12: also visual). Without cursors: next · previous change in diff mode, as usual | multi cursor, cycle, switch cursor, main cursor |
| `<leader>md` | n | 0.12: delete the main cursor · 0.13+: remove the cursor under the main cursor (use after `]c`) | multi cursor, delete cursor, remove cursor |
| `g<C-a>` · `g<C-x>` | n, v | 0.12: turn the numbers at the cursors into 1, 2, 3 … (`g<C-x>` counts down) · 0.13+: `g<C-a>` inserts 1, 2, 3 … | multi cursor, sequence, increment, numbering, counter |
| `<leader>m=` | n | Line all cursors up in one column, padding with spaces; 0.12 only | multi cursor, align, columns |
| `<leader>mt` · `<leader>mT` | v | Rotate the selected texts forward · backward between cursors; 0.12 only | multi cursor, rotate, swap, transpose |
| `<Left>` · `<Right>` | n, v | Same as `[c` · `]c`, if your arrow keys work; 0.12 only | multi cursor, arrows, cycle |

On 0.12, `]c` `[c` `<Left>` `<Right>` `g<C-a>` `g<C-x>` and `<Esc>`-to-clear
only exist while there are extra cursors, so they never get in the way of
normal editing.

### Recipes

1. **Rename some occurrences of a word.** Cursor on the word, `<C-n>` once
   per extra occurrence (`<leader>ms` skips one you don't want), then
   `ciw` *newname* `<Esc>`, then `<Esc>`. All of them: `<leader>ma`.
   Matching is whole-word and case-sensitive, so `foo` won't grab `foobar`.
   For other text (`foo.bar`, part of a word) select it first and press
   `<C-n>` on the selection — then `c` replaces every selection on 0.12, and
   `cgn` ("change match") does it on 0.13+.
2. **Edit many lines at once.** `V` `j` `j` `j` then `I` (start) or `A` (end),
   type, `<Esc>` `<Esc>`. Or build a column with `<A-J>` `<A-J>` … and use any
   command — `i`, `a`, `ciw`, `dw`, `x`, `r`, `>>`, `~` …
3. **One cursor per line of a motion.** `gaip`, `ga4j`, `gaG`.
4. **Cursors in arbitrary places.** `<C-q>` drops a cursor here and freezes
   the others; move anywhere (`w`, `/foo<CR>`, `f(` … only the main cursor
   moves) and `<C-q>` again; `<Esc>` unfreezes, then edit. With a mouse:
   Ctrl+click.
5. **From a search.** `/pattern<CR>` then `<leader>m/`. `/\d\+` then
   `<leader>m/` puts a cursor on every number.
6. **Only inside a function.** 0.12: `<leader>mm iw af` (`af` = the function
   text object; `ip` = the paragraph). 0.13+: select it (`vaf`), then
   `<leader>m/` and a regex.
7. **Regex in a selection.** Select, `<leader>m/`, type e.g. `\w\+`, `<CR>`:
   a cursor on each match. 0.12: `c` replaces them; 0.13+: `gv` then `c`.
   0.12 also splits a selection: `red, green, blue` → `<leader>m|` → `, `.
8. **Number lines 1, 2, 3 …** (0.12) Cursors on lines with a number (`item 0`
   × 4), `$`, `g<C-a>` → `item 1` … `item 4`. `10g<C-a>` steps by 10.
9. **Align on `=`** (0.12) `gaip`, `f=`, `<leader>m=`.

### Good to know

- **Typing:** on 0.12 you type at the main cursor and the others receive the
  text the moment you press `<Esc>`; on 0.13+ it appears everywhere live.
  Completion (`<CR>`) and auto-pairs work at every cursor.
- **Moving in insert mode** with `<Up>`/`<Down>`/`<C-Insert>` starts a new
  edit, so only what you type after it is copied — leave insert mode to move.
  `<Insert>` (move right) is fine.
- **Frozen cursors** (after `<C-q>`) stay put while you move and the
  statusline says "(frozen)". On 0.12 they also ignore edits until you
  unfreeze (`<Esc>`); on 0.13+ edits still happen at them.
- **Undo** (`u` / `<C-r>`) is one step for all cursors; on 0.12 it also
  brings back the cursors of that edit. **Macros** (`@q`) run at every cursor.
- **which-key** popups are hidden while there are extra cursors on 0.12 — the
  keys still work. **Switching windows** clears the cursors on 0.12; on 0.13+
  they stay with their buffer.
- **Keys this takes over:** `<C-q>` (was a synonym of `<C-v>`: use `<C-v>`),
  `ga` (`:ascii` still works), `<C-n>` in normal / visual mode (was `j`), and
  visual `I` / `A` (now every selected line, not just the first; block mode is
  unchanged). In insert mode `<C-n>` is still "next completion".

### Multi-cursor on Neovim 0.13+

Neovim 0.13 (in nightly builds today) builds multiple cursors into the editor
(`:h multicursor`). Builds that have them also have the `'follow'` option; this
config checks for it, keeps multicursor.nvim installed but unloaded, and wires
the keys above to the built-in cursors (`lua/core/multicursor.lua`). An older
0.13-dev build without built-in cursors keeps using the plugin.

| | 0.12 (plugin) | 0.13+ (built in) |
| --- | --- | --- |
| Text typed at all cursors | after `<Esc>` | live |
| Editing while frozen (`<C-q>`) | main cursor only | every cursor |
| Visual `<C-n>`, then edit | `c` | `cgn` |
| Visual `<leader>m/`, then edit | `c` | `gv` then `c` |
| `g<C-a>` | renumbers existing numbers | inserts 1, 2, 3 … |
| `<leader>mm` | text object inside a range | `zq{motion}` |
| `<leader>m=` · `<leader>m\|` · `<leader>mt` · `<Left>`/`<Right>` | yes | — |
| which-key popup while cursors exist | hidden | shown |

Built-in keys you also get on 0.13+:

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `Q` | n | Toggle a cursor here (built-in, 0.13+; on 0.12 `Q` replays the last macro — on 0.13 use `@@`) | multi cursor, built-in, toggle cursor, macro |
| `zq` | n, v | A cursor at every target of a motion: `zqw` every word, `zq*` every match, `vipzqj` every line (built-in, 0.13+) | multi cursor, built-in, every word, every match |
| `q=` | n | Toggle "follow": motions move every cursor, or only the main one (built-in, 0.13+) | multi cursor, built-in, follow, freeze |
| `]C` · `[C` | n | Jump to the next · previous cursor (built-in, 0.13+) | multi cursor, built-in, jump to cursor |
| `gQ` | n | Bring back the last cursors (built-in, 0.13+) | multi cursor, built-in, restore |

## Insert mode, completion & command line

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<Insert>` | i | Move the cursor right without splitting the edit: `.`, undo and multi-cursor typing still see the whole insert | right, arrow key, cursor, move, skip bracket |
| `<C-Insert>` | i | Move the cursor down | down, arrow key, cursor, move |
| `(` `[` `{` `"` `'` | i | Brackets and quotes (and backticks) close themselves; typing the closing one steps over it, `<BS>` deletes both halves, `<CR>` between brackets opens a line inside (mini.pairs) | autopairs, auto close, brackets, quotes, parentheses |

### Completion menu

| Key | Action | Keywords |
| --- | --- | --- |
| `<Tab>` · `<S-Tab>` | Next · previous suggestion; also jumps between snippet fields | complete, next, previous, snippet |
| `<C-n>` · `<C-p>` | Next · previous suggestion (`<Down>` · `<Up>` too) | complete, next, previous |
| `<CR>` | Accept the selected suggestion | accept, confirm, complete |
| `<C-Space>` | Open the menu; press again to toggle the docs | open completion, trigger, docs |
| `<C-e>` | Close the menu (and undo the inserted preview) | cancel, close, dismiss |
| `<C-f>` | Scroll the docs down | scroll docs |
| `<C-d>` · `<C-b>` | Scroll the docs up | scroll docs |
| `<C-k>` | Show or hide the function signature | signature, parameters |

The first suggestion is preselected, so <kbd>Enter</kbd> accepts it. For a
plain new line while the menu is open, press `<C-e>` first.

### Command line

| Key | Action | Keywords |
| --- | --- | --- |
| `<Tab>` · `<S-Tab>` | Complete; press again to cycle forward · backward | complete, command, cmdline |
| `<C-n>` · `<C-p>` | Next · previous completion (`<Right>` · `<Left>` too while the menu is open) | complete, next, previous, cmdline |
| `<C-Space>` | Show completions | complete, cmdline |
| `<C-y>` | Accept the selected completion | accept |
| `<C-e>` | Cancel completion | cancel |

## Motions (flash)

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `s` | n, v, o | Flash jump: type the characters you're looking at, then the label next to the match | jump, flash, motion, easymotion, hop, leap, go to, anywhere |
| `S` | n, v, o | Flash treesitter: pick a code block by label to select or operate on it | select, treesitter, node, block, flash |
| `r` | o | Remote flash: after an operator, jump somewhere, act on text there, come back (e.g. `yr`) | remote, operator, flash, yank remote |
| `R` | v, o | Treesitter search: search, then pick the code block around a match | treesitter search, flash, select |
| `f` `F` `t` `T` | n, v, o | Find a character; flash highlights targets, works across lines, press the same key again for the next match | find char, motion, line, clever-f |
| `;` · `,` | n, v, o | Repeat the last `f`/`t` forward · backward | repeat, next, previous |
| `<C-s>` | c | While searching with `/` or `?`, toggle flash jump labels | search, flash, toggle, labels |

## Surround

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `gsa` | n, v | Add a surrounding: `gsaiw"` wraps a word in quotes; in visual mode just type the character | surround, add, wrap, quotes, brackets, parentheses |
| `gsd` | n | Delete a surrounding: `gsd"` | surround, delete, remove, unwrap |
| `gsr` | n | Replace a surrounding: `gsr"'` turns `"x"` into `'x'` | surround, replace, change |
| `gsf` | n, v, o | Find the next surrounding to the right | surround, find, next |
| `gsF` | n, v, o | Find the previous surrounding to the left | surround, find, previous |
| `gsh` | n | Highlight a surrounding | surround, highlight, show |
| `gsn` | n | Change how many lines are searched for surroundings | surround, n_lines, lines, settings |

Characters you can use: `)` `]` `}` `>` for brackets, `(` `[` `{` `<` for
brackets plus the spaces just inside them, quotes, `t` for an HTML tag, `f` for
a function call, `b` for any bracket, `q` for any quote, and `?` to type both
sides yourself. Add `n` or `l` after `gsd` `gsr` `gsf` `gsF` `gsh` to target
the next or last pair, e.g. `gsdn)`.

## Text objects & code navigation

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `af` | v, o | Around a function, e.g. `daf`, `vaf`, `yaf` | function, method, textobject, select, outer |
| `if` | v, o | Inside a function body | function, body, inner, textobject |
| `ac` | v, o | Around a class | class, struct, type, textobject, outer |
| `ic` | v, o | Inside a class | class, inner, textobject |
| `aa` | v, o | Around a parameter (with its comma) | parameter, argument, arg, param, textobject |
| `ia` | v, o | Inside a parameter | parameter, argument, arg, param, textobject |
| `]f` | n, v, o | Jump to the next function | next function, method, navigate |
| `[f` | n, v, o | Jump to the previous function | previous function, method, navigate |
| `]a` | n, v, o | Jump to the next parameter | next parameter, argument |
| `[a` | n, v, o | Jump to the previous parameter | previous parameter, argument |
| `an` | v, o | Select the parent syntax node; repeat to grow (built-in) | expand selection, incremental selection, grow, node |
| `in` | v, o | Select a child syntax node; repeat to shrink (built-in) | shrink selection, incremental selection, node |
| `]n` | v | Move the selection to the next syntax node (built-in) | next node, sibling, selection |
| `[n` | v | Move the selection to the previous syntax node (built-in) | previous node, sibling, selection |
| `]N` · `[N` | v | Grow the selection over the next · previous sibling node (built-in) | extend selection, sibling, grow |

## Folds

Treesitter decides where code folds, and every fold starts open. These are
Neovim's own keys.

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `za` | n | Toggle the fold under the cursor (built-in) | fold, collapse, expand, toggle |
| `zc` | n | Close the fold (built-in) | fold, collapse, close, hide |
| `zo` | n | Open the fold (built-in) | unfold, open, expand |
| `zM` | n | Close every fold (built-in) | fold all, collapse all |
| `zR` | n | Open every fold (built-in) | unfold all, expand all |

## TODO comments

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `]t` | n | Next TODO / FIXME / HACK / NOTE comment | todo, fixme, hack, note, next |
| `[t` | n | Previous TODO comment | todo, fixme, previous |
| `<leader>ft` | n | Search every TODO comment (picker) | todo, fixme, list, search, picker |
| `<leader>xt` | n | TODO comments list (Trouble) | todo, fixme, list, trouble |

## Git

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `]h` | n | Next changed hunk (git) | git, hunk, change, diff, next |
| `[h` | n | Previous changed hunk (git) | git, hunk, change, diff, previous |
| `]H` · `[H` | n | Last · first hunk in the file (git) | git, hunk, last, first |
| `<leader>ga` | n, v | Stage the hunk under the cursor, or unstage it if it's already staged; in visual mode only the selected lines (git) | git add, stage, unstage, hunk, partial, lines |
| `<leader>gr` | n, v | Reset the hunk under the cursor, discarding the change; in visual mode only the selected lines (git) | git reset, discard, revert, undo change, checkout, partial |
| `<leader>gS` | n | Stage the whole file (git) | git add, stage file, stage all |
| `<leader>gR` | n | Reset the whole file, discarding its changes (git) | git reset, discard file, revert file |
| `<leader>gp` | n | Preview the hunk's diff (git) | preview, diff, hunk |
| `<leader>gi` | n | Preview the hunk inline, in the buffer (git) | preview, inline, diff, hunk |
| `<leader>gb` | n | Blame this line, with the full commit message (git) | blame, who, author, commit, annotate |
| `<leader>gB` | n | Toggle inline blame on every line (git) | blame, inline, virtual text, toggle, author |
| `ih` | v, o | The hunk as a text object, e.g. `vih`, `dih` (git) | hunk, textobject, select |
| `<leader>gs` | n | Neogit: status, stage, commit, push, pull, branch, stash | git status, commit, push, pull, magit, stage, branch, stash, neogit |
| `<leader>gd` | n | Diff every uncommitted change (Diffview) | diff, changes, diffview, review |
| `<leader>gm` | n | Resolve merge conflicts in a 3-way view (Diffview) | merge, conflict, resolve, 3-way, mergetool |
| `<leader>gh` | n | History of this file (Diffview) | file history, log, commits |
| `<leader>gH` | n | History of the current branch (Diffview) | branch history, log, commits |
| `<leader>gq` | n | Close Diffview | close diff, quit diff, diffview |
| `<leader>gl` | n | Git log picker. Careful: Enter checks out the commit (detached HEAD); `<Esc>` to just look | git log, commits, history, checkout |
| `<leader>gL` | n | History of the current line (picker) | git log, line history, who changed, blame history |
| `<leader>go` | n, v | Open the file — or the selected lines — on GitHub / GitLab in the browser | browse, github, gitlab, open in browser, permalink, url |

### Inside Neogit

| Key | Action | Keywords |
| --- | --- | --- |
| `?` | Show every Neogit key and menu | help |
| `s` · `u` | Stage · unstage the file or hunk under the cursor | stage, unstage, git add |
| `S` · `U` | Stage everything unstaged · unstage everything staged | stage all, unstage all |
| `x` | Discard the change under the cursor | discard, revert, reset |
| `<Tab>` | Expand or collapse the file or section | fold, expand, diff |
| `<CR>` | Open the file | open, goto |
| `c` | Commit menu (then `c` again to write the message) | commit |
| `P` · `p` | Push menu · pull menu | push, pull, sync, remote |
| `b` | Branch menu | branch, checkout, switch |
| `Z` | Stash menu | stash |
| `l` | Log menu | log, history |
| `q` | Close Neogit | close, quit |

### Writing a commit message (Neogit)

| Key | Action | Keywords |
| --- | --- | --- |
| `<C-c><C-c>` | Finish the commit | commit, submit, save, done |
| `<C-c><C-k>` | Abort the commit | abort, cancel |

### Inside Diffview

| Key | Action | Keywords |
| --- | --- | --- |
| `<Tab>` · `<S-Tab>` | Next · previous file | next file, files |
| `]x` · `[x` | Next · previous merge conflict | conflict, next, previous |
| `<leader>co` | Choose OURS for this conflict | ours, conflict, resolve, local |
| `<leader>ct` | Choose THEIRS for this conflict | theirs, conflict, resolve, remote, incoming |
| `<leader>cb` | Choose BASE for this conflict | base, conflict, resolve |
| `<leader>ca` | Keep all versions of this conflict | all, both, conflict, resolve |
| `dx` | Delete the conflict region | delete, none, conflict |
| `<leader>cO` · `<leader>cT` · `<leader>cB` · `<leader>cA` · `dX` | Same as above, for every conflict in the file | whole file, all conflicts, resolve |
| `<leader>e` · `<leader>b` | Focus · toggle the file panel | files, panel, sidebar |
| `g?` | Show every Diffview key | help |

Inside Diffview, `<leader>e` focuses Diffview's file panel instead of opening
netrw.

## Debugging (DAP)

Debugging works for Go (delve), Python (debugpy) and Rust / Zig / C / C++
(codelldb). Many terminals grab `<F10>` / `<F11>` for themselves. If they do
nothing, use the `<leader>d` keys.

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>db` | n | Toggle a breakpoint | breakpoint, debug, dap, pause, stop here |
| `<leader>dB` | n | Set a conditional breakpoint (asks for the condition) | breakpoint, condition, conditional, debug |
| `<leader>dc` | n | Start or continue debugging | debug, start, run, continue, launch, resume |
| `<F5>` | n | Start or continue debugging | debug, start, run, continue, launch, resume |
| `<leader>dC` | n | Run to the cursor | run to cursor, debug |
| `<leader>dO` | n | Step over | step over, next line, debug |
| `<F10>` | n | Step over | step over, next line, debug |
| `<leader>di` | n | Step into | step into, enter function, debug |
| `<F11>` | n | Step into | step into, enter function, debug |
| `<leader>do` | n | Step out | step out, finish, return, debug |
| `<F12>` | n | Step out | step out, finish, return, debug |
| `<leader>de` | n, v | Evaluate the expression under the cursor or the selection | eval, evaluate, inspect, value, variable, watch |
| `<leader>du` | n | Toggle the debugger UI | dap ui, panels, variables, scopes, toggle |
| `<leader>dr` | n | Toggle the debug REPL | repl, console |
| `<leader>dl` | n | Run the last debug session again | run last, again, restart |
| `<leader>dt` | n | Terminate the debug session | stop, terminate, kill, quit debugging |

### Inside the debugger UI

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Expand or collapse a variable | expand, variables, scopes |
| `e` | Edit a variable's value | edit, set value |
| `o` | Jump to the frame or breakpoint in the code | open, jump, stack, frame |
| `d` | Remove a watch or breakpoint | remove, delete |
| `t` | Enable or disable a breakpoint | toggle, breakpoint |
| `r` | Send to the REPL | repl |
| `q` · `<Esc>` | Close a floating window, e.g. an evaluation result | close |

## Testing (neotest)

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>tt` | n | Run the nearest test | test, run, nearest, unit test, this test |
| `<leader>tf` | n | Run every test in this file | test file, run file |
| `<leader>ta` | n | Run every test in the project (cwd) | all tests, suite, project |
| `<leader>tl` | n | Re-run the last test | rerun, last, again |
| `<leader>td` | n | Debug the nearest test (delve / debugpy) | debug test, dap, breakpoint |
| `<leader>tS` | n | Stop the running tests | stop, cancel, kill, abort |
| `<leader>ts` | n | Toggle the test summary tree | summary, tree, overview, results, panel |
| `<leader>to` | n | Show the output of the test under the cursor | output, result, log, failure |
| `<leader>tO` | n | Toggle the test output panel | output panel, log |
| `<leader>tw` | n | Watch this file: re-run its tests when related files change | watch, auto, rerun, tdd |

### Inside the test summary

| Key | Action | Keywords |
| --- | --- | --- |
| `r` | Run the test under the cursor | run |
| `d` | Debug the test under the cursor | debug |
| `o` | Show its output | output |
| `i` | Jump to the test in the code | jump, goto, open |
| `<CR>` | Expand or collapse | expand, collapse |
| `J` · `K` | Next · previous failed test | failed, failure, next, previous |
| `u` | Stop the test | stop |
| `?` | Show every summary key | help |

## UI toggles

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>us` | n | Toggle spell checking | spell, spelling, typos, spellcheck |
| `<leader>uw` | n | Toggle line wrapping | wrap, long lines, soft wrap |
| `<leader>ur` | n | Toggle relative line numbers | relative numbers, relativenumber |
| `<leader>ul` | n | Toggle line numbers | line numbers, number, gutter |
| `<leader>ud` | n | Toggle diagnostics on or off | diagnostics, errors, hide, show |
| `<leader>uh` | n | Toggle inlay hints (LSP) | inlay hints, type hints, hints |
| `<leader>ug` | n | Toggle indent guides | indent guides, indentation, lines |
| `<leader>uf` | n | Toggle format on save, everywhere | format on save, autoformat, disable formatting |
| `<leader>uF` | n | Toggle format on save for this buffer only | format on save, autoformat, buffer |
| `<leader>uT` | n | Toggle treesitter highlighting | treesitter, syntax highlighting |
| `<leader>uc` | n | Toggle conceal (hidden markup in markdown, JSON quotes…) | conceal, conceallevel, markdown |
| `<leader>ub` | n | Toggle dark / light background | background, light, dark, theme |
| `<leader>uz` | n | Toggle zen mode | zen, focus, distraction free |
| `<leader>uZ` | n | Toggle zoom: maximise the current window | zoom, maximize, fullscreen, window |
| `<leader>ui` | n | Inspect the highlight groups under the cursor | inspect, highlight, colors, hl group, show_pos |
| `<leader>uI` | n | Inspect the syntax tree | inspect tree, treesitter, syntax tree, ast |

## Terminal & tools

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<C-/>` | n, t | Toggle a floating terminal; terminals that send `<C-_>` work too. Inside it, `<Esc><Esc>` = normal mode | terminal, shell, console, toggle, float, command line |
| `<C-\><C-n>` | t | Leave terminal mode in any terminal (built-in) | terminal, normal mode, escape |
| `<leader>l` | n | Lazy plugin manager (`U` update, `S` sync, `X` clean) | plugins, lazy, update, install, plugin manager |

Language servers and tools are installed with `:Mason`.

## Inside pickers

### Snacks pickers

Used by `<leader>?`, `<leader>fb`, `<leader>fr`, `<leader>fs`, `<leader>fd`,
`<leader>fu` and the other snacks finders.

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Open or run the selected item | open, confirm, select |
| `<C-j>` · `<C-k>` | Move down · up (`<C-n>` · `<C-p>` and the arrows work too) | move, next, previous, navigate |
| `<C-s>` · `<C-v>` · `<C-t>` | Open in a split · vertical split · new tab | split, vsplit, tab |
| `<Tab>` | Select several items | multi select, mark |
| `<C-q>` | Send the items to the quickfix list | quickfix |
| `<C-f>` · `<C-b>` | Scroll the preview down · up | scroll preview |
| `<C-d>` · `<C-u>` | Scroll the list down · up | scroll list |
| `<A-p>` | Toggle the preview | preview, hide preview |
| `<A-h>` · `<A-i>` | Show hidden · git-ignored files | hidden, ignored, dotfiles |
| `<A-m>` | Maximize the picker | maximize, fullscreen |
| `<Esc>` | Stop typing (normal mode); `<Esc>` again or `q` closes | close, cancel, normal mode |
| `<C-c>` | Close while typing | close, cancel |
| `?` | In normal mode, show every picker key | help |

In `<leader>?`, `<CR>` runs the selected key, and `<C-s>` · `<C-v>` · `<C-t>`
open this file at that row.

### fff (`<leader>ff`, `<leader>fg`, `<leader>fz`)

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Open the file | open |
| `<C-s>` · `<C-v>` · `<C-t>` | Open in a split · vertical split · new tab | split, vsplit, tab |
| `<C-n>` · `<C-p>` | Move down · up (the arrows work too) | move, next, previous |
| `<C-d>` · `<C-u>` | Scroll the preview | scroll preview |
| `<Tab>` | Select several files | multi select, mark |
| `<C-q>` | Send the selection to the quickfix list | quickfix |
| `<S-Tab>` | In grep: cycle plain / regex / fuzzy matching | grep mode, regex, fuzzy, plain |
| `<C-Up>` · `<C-Down>` | Previous · next query from history | history |
| `<Esc>` | Close | close, cancel |

## Inside other windows

### which-key popup

| Key | Action | Keywords |
| --- | --- | --- |
| `<BS>` | Go back up one level | back, up |
| `<C-d>` · `<C-u>` | Scroll the popup | scroll |
| `<Esc>` | Close the popup | close, cancel |

### Floating terminal (`<C-/>`)

| Key | Action | Keywords |
| --- | --- | --- |
| `<Esc><Esc>` | Leave terminal mode (normal mode in the terminal buffer) | normal mode, scroll, copy |
| `<C-/>` | Hide the terminal; press again to bring it back | hide, toggle, terminal |

### Help, man, quickfix and checkhealth windows

| Key | Action | Keywords |
| --- | --- | --- |
| `q` | Close the window | close, quit |

### Input prompts

Text prompts, such as the one `<leader>rn` opens.

| Key | Action | Keywords |
| --- | --- | --- |
| `<CR>` | Confirm | confirm, accept, ok |
| `<Esc>` | Stop typing; `<Esc>` again or `q` cancels | cancel, close |
| `<Up>` · `<Down>` | Previous · next entry from history | history |

## Vim defaults this config changes

If you already know Vim, these are the keys that behave differently here.

- `s` and `S` belong to flash (jump / treesitter select). The originals are
  `cl` and `cc`.
- `H` is previous buffer and `L` is next tab, instead of moving the cursor to
  the top or bottom of the window.
- `<C-l>` moves to the right window instead of clearing highlights and
  redrawing. Clear highlights with `<Esc>` or `<leader>h`.
- `]t` / `[t` jump between TODO comments, not tags.
- `]a` / `[a` jump between parameters, not files in the argument list.
- `]f` / `[f` jump between functions instead of editing the file under the
  cursor.
- `]d` / `[d` also show the diagnostic message in a float.
- `gt` is go to type definition in LSP buffers. Use `L` for the next tab.
- `gs` is the surround prefix (it used to sleep).
- `J` / `K` in visual mode move the selection instead of joining lines or
  looking up the word.
- `R` in visual mode is treesitter search instead of replacing lines.
- `f` `F` `t` `T` work across lines and show flash highlights.
- `<Insert>` in insert mode moves right instead of switching to Replace mode.
- `<C-n>` (normal / visual), `<C-q>`, `ga` and visual `I` / `A` are
  multi-cursor keys. The originals: `j`, `<C-v>`, `:ascii`, and `I` / `A` that
  only touch the first line (block mode is unchanged).
- `<Esc>` in normal mode also clears search highlights (and extra cursors).
- `j` / `k` move by screen line on wrapped text (by real line with a count).
- `gr` fires instantly in LSP buffers, so Neovim's `grn` `grr` `gri` `grt`
  `grx` can't be typed there (see *Code intelligence*).
- On Neovim 0.13+, `Q` toggles a cursor instead of replaying the last macro
  (Neovim's own change; use `@@`).
- `:q` asks to save unsaved changes instead of failing, and `q` closes help,
  man, quickfix and checkhealth windows.

## What's new

- **Multi-cursor** — [its own section](#multi-cursor); plugin on 0.12,
  Neovim's built-in cursors on 0.13+, same keys.
- **Fixed:** `gr` no longer pauses `timeoutlen` (~0.4 s) on every use;
  visual `<leader>ga` / `<leader>gr` stage / reset only the selected lines
  (they acted on the whole hunk); `<Insert>` no longer splits the insert, so
  `.` and undo cover all of it; the dead `<S-l>` mapping is gone (`L` stays
  next tab, `]b` is next buffer); `gsf` / `gsF` also work from visual and
  operator-pending mode before surround has loaded; on Neovim 0.13 yank
  highlighting no longer warns on every yank (`vim.hl.on_yank` is deprecated
  there).
- **New keys:** `<Esc>` clears highlights · wrap-aware `j` / `k` ·
  `<leader>ss` · `<leader>wa` · `<leader>qa` · `<leader>Ln` / `Lc` / `Lo` ·
  `]e` `[e` `]w` `[w` `]r` `[r` · pickers `<leader>fw` `fj` `fm` `f"` `fq`
  `fn` `fH` and visual `<leader>sg` · LSP `gK`, visual `<leader>ca`,
  `<leader>rf` · git `]H` `[H` `<leader>gS` `gR` `gi` `gL` `go` · toggles
  `<leader>uf` `uF` `uT` `uc` `ub` `uz` `uZ` `ui` `uI` · `<C-/>` terminal ·
  `<leader>l` Lazy.
- **Plugins** updated to their latest commits and tested on Neovim 0.12.6
  and 0.13-dev nightly.

## Adding or changing a keybinding

`<leader>?` reads this file directly, so keep it in sync with the config:

- Editor keymaps live in `lua/core/keymaps.lua`. Plugin keymaps live in that
  plugin's spec under `lua/plugins/`.
- Every row of a table whose header has `Key` and `Action` columns becomes a
  search entry. `Mode` and `Keywords` are optional.
- Put keys in backticks. A row whose Key cell is a single key and whose Mode
  includes `n` can be run from `<leader>?`.
- Separate modes with commas (`n, v`). Leave the Mode column out for keys that
  only work inside one plugin's window, like the "Inside …" tables above.
- Write `\|` for a literal `|` inside a cell.
