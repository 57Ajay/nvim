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

## How to read the tables

| Notation | Meaning |
| --- | --- |
| `<leader>` | <kbd>Space</kbd>. `<leader>ff` means press Space, then `f`, then `f` |
| `<localleader>` | Also <kbd>Space</kbd> (used inside some plugin windows) |
| `<C-x>` · `<A-x>` · `<S-x>` | Ctrl+x · Alt+x · Shift+x |
| `H`, `L`, `S`… | A capital letter means Shift + that letter |
| `<CR>` · `<Esc>` · `<BS>` · `<Tab>` | Enter · Escape · Backspace · Tab |
| Mode `n` · `v` · `o` | Normal · visual · operator-pending (right after an operator such as `d`, `y`, `c`) |
| Mode `i` · `c` | Insert · command line (`:` or `/`) |

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
- [Inside pickers](#inside-pickers)
- [Inside other windows](#inside-other-windows)
- [Vim defaults this config changes](#vim-defaults-this-config-changes)
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
| `<leader>q` | n | Quit the window (asks before dropping unsaved changes) | quit, exit, close window, leave |
| `<leader>qs` | n | Restore the session for this directory and git branch | session, restore, resume, reopen, persistence |
| `<leader>ql` | n | Restore the last session | session, last, restore, resume |
| `<leader>qd` | n | Don't save the current session on exit | session, stop, disable, forget |

`<leader>w`, `<leader>q` and `<leader>c` are also the first keys of longer
sequences (`<leader>wl`, `<leader>qq`/`qs`/`ql`/`qd`, and `<leader>ca` in LSP
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

**Heads-up:** `lua/core/keymaps.lua` also maps `<S-l>` to *next buffer*, but
`<S-l>` and `L` are the same key, and the later *next tab* mapping wins. Use
`]b` for the next buffer.

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

## Search & replace

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<leader>h` | n | Clear search highlighting | nohlsearch, clear highlight, unhighlight, search |
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
| `gr` | n | List references (LSP) | references, usages, callers, find usages |
| `gi` | n | Go to implementation (LSP) | implementation, interface, goto |
| `gt` | n | Go to type definition (LSP); in LSP buffers this replaces Vim's next-tab `gt`, use `L` | type, type definition, goto |
| `K` | n | Hover documentation (LSP) | hover, docs, documentation, info, type info |
| `<leader>rn` | n | Rename the symbol everywhere (LSP) | rename, refactor, symbol, variable |
| `<leader>ca` | n | Code actions and quick fixes (LSP) | code action, quick fix, lightbulb, import, refactor |
| `<leader>f` | n, v | Format the buffer or selection (conform; also runs on save) | format, prettier, beautify, indent, style, stylua, gofmt |
| `<C-s>` | i | Show the function signature while typing (built-in) | signature, parameters, arguments, help |
| `grn` | n | Rename (built-in LSP key) | rename, refactor |
| `gra` | n, v | Code action (built-in LSP key) | code action, quick fix |
| `grr` | n | References in the quickfix list (built-in LSP key) | references, usages |
| `gri` | n | Go to implementation (built-in LSP key) | implementation |
| `grt` | n | Go to type definition (built-in LSP key) | type definition |
| `grx` | n | Run the code lens on this line (built-in LSP key) | codelens, code lens, run |
| `gO` | n | Document symbols in the location list (built-in LSP key) | symbols, outline |

Because Neovim's own `grn`, `grr`… also start with `gr`, plain `gr` fires
after the same short `timeoutlen` pause.

## Diagnostics & lists

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `]d` | n | Next diagnostic, with its message in a float | diagnostic, error, warning, problem, next |
| `[d` | n | Previous diagnostic, with its message in a float | diagnostic, error, warning, problem, previous |
| `]D` | n | Last diagnostic in the buffer (built-in) | diagnostic, last |
| `[D` | n | First diagnostic in the buffer (built-in) | diagnostic, first |
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

## Insert mode, completion & command line

| Key | Mode | Action | Keywords |
| --- | --- | --- | --- |
| `<Insert>` | i | Move the cursor right | right, arrow key, cursor, move |
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
| `]n` | v | Select the next sibling node (built-in) | next node, sibling, selection |
| `[n` | v | Select the previous sibling node (built-in) | previous node, sibling, selection |

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
| `<leader>ga` | n, v | Stage the hunk under the cursor, or unstage it if it's already staged (git) | git add, stage, unstage, hunk |
| `<leader>gr` | n, v | Reset the hunk under the cursor, discarding the change (git) | git reset, discard, revert, undo change, checkout |
| `<leader>gp` | n | Preview the hunk's diff (git) | preview, diff, hunk |
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
  redrawing. Clear highlights with `<leader>h`.
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
- `:q` asks to save unsaved changes instead of failing, and `q` closes help,
  man, quickfix and checkhealth windows.

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
