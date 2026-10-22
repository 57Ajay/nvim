# Keybindings

Leader is **Space**. Press it and wait half a second — which-key pops up and
lists everything under it. **`<leader>fk`** opens a fuzzy-searchable list of
*every* keymap with its description (type "cursor", "git", "format", …), so
you never have to memorise this file.

**Notation:** `<C-x>` = Ctrl+x · `<A-x>` = Alt+x (`<A-J>` = Alt+Shift+j) ·
`<S-x>` = Shift+x · `<CR>` = Enter · `<leader>` = Space.
**Mode column:** **n** normal · **v** visual (any selection) · **i** insert ·
**o** after an operator such as `d`, `c`, `y` (motions / text objects) ·
**t** terminal.

- [What's new in this update](#whats-new-in-this-update)
- [Multi-cursor](#multi-cursor) — guide, recipes, full reference, Neovim 0.13
- [Everyday editing](#everyday-editing)
- [Moving around](#moving-around)
- [Find (pickers)](#find-pickers)
- [LSP / code](#lsp--code)
- [Diagnostics & lists](#diagnostics--lists)
- [Git](#git)
- [Search & replace, sessions](#search--replace-sessions)
- [Debug](#debug-leaderd) · [Test](#test-leadert)
- [Completion (insert mode)](#completion-insert-mode)
- [UI toggles](#ui-toggles-leaderu)
- [Terminal & tools](#terminal--tools)
- [Built into Neovim (no plugin needed)](#built-into-neovim-no-plugin-needed)
- [Keys that differ from stock Vim](#keys-that-differ-from-stock-vim)
- [Troubleshooting keys](#troubleshooting-keys)

---

## What's new in this update

**Multi-cursor** — `<C-n>`, `<A-J>`/`<A-K>`, visual `I`/`A`, `ga`, `<C-q>`,
Ctrl+click and the whole `<leader>m` group. See [Multi-cursor](#multi-cursor).

**Fixed**

- **Shift+L now goes to the next buffer.** `L` *is* Shift+L, and the old
  `L` → "next tab" mapping silently replaced "next buffer". Next/previous
  tab is the built-in `gt` / `gT` (plus `<leader>L1`…`9`, `<leader>Ln/Lc/Lo`).
- **`gr` (LSP references) is instant.** It used to wait 0.4 s on every use,
  because Neovim 0.11+ ships `grn`/`grr`/`gra`/`gri`/`grt`/`grx` built in.
- **Visual `<leader>ga` / `<leader>gr` stage / reset only the selected
  lines.** They used to act on the whole hunk.
- **`<Insert>` (move right in insert mode) no longer splits your edit:** `.`
  repeat, undo and multi-cursor typing now see the whole insert.
- **Neovim 0.13 ready:** yank highlighting uses `vim.hl.hl_op` when it exists
  (0.13 deprecates `vim.hl.on_yank`, which warned on *every* yank), and
  multi-cursor uses Neovim's built-in cursors there.
- **Plugins updated** to their latest commits (`lazy-lock.json`), tested on
  Neovim 0.12.6 and 0.13-dev nightly.

**New keys** — `<Esc>` clears search highlight · wrap-aware `j`/`k` ·
`<leader>ss` substitute word · `]e`/`[e` errors · `]w`/`[w` warnings ·
`]r`/`[r` references · `<leader>wa` save all · `<leader>qa` quit all ·
`<leader>l` Lazy · `<C-/>` floating terminal · pickers `<leader>fw`
`fj` `fm` `f"` `fq` `fn` `fH` + visual `<leader>sg` · LSP `gK`, visual
`<leader>ca`, `<leader>rf` · git `]H`/`[H`, `<leader>gS`/`gR`/`gi`/`gL`/`go` ·
toggles `<leader>uf`/`uF`/`uT`/`uc`/`ub`/`uz`/`uZ`/`ui`/`uI`.

---

## Multi-cursor

### How it works (30-second version)

1. **Add cursors** with one of the keys below. Extra cursors are highlighted
   and the statusline shows **"N cursors"**.
2. **Edit exactly like normal Vim.** Every operator, text object, insert, `.`
   repeat, paste, macro, `>>`, `gU`, `r`, … runs at **every** cursor. Motions
   (`w`, `e`, `f(`, `$`, …) move all cursors together.
3. **`<Esc>` in normal mode** goes back to one cursor. A single `u` undoes the
   edit at all cursors at once.

None of this needs the arrow keys. The cursor the screen follows is the
**main** cursor; the newest cursor you add becomes the main one.

> On **Neovim 0.12** (current stable) this comes from the
> [multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) plugin.
> On **Neovim 0.13+**, which has multiple cursors built in, the *same keys*
> drive the built-in cursors instead (the plugin isn't compatible with them
> yet). Everything below works on both unless marked **0.12 only**; the
> differences are listed in [Multi-cursor on Neovim 0.13+](#multi-cursor-on-neovim-013).

### The keys to remember

| Key | Mode | What it does |
| --- | --- | --- |
| `<C-n>` | n, v | Add a cursor at the **next match** of the word under the cursor (or of the selection). Press again for more. Like VS Code's Ctrl+D. |
| `<A-J>` / `<A-K>` | n | Add a cursor on the line **below / above** (Alt+Shift+j / k). Hold it to build a column. |
| `I` / `A` | v | **Insert / append on every selected line** — `V`, `j` `j` `j`, then `I` |
| `<leader>ma` | n, v | A cursor on **every** match in the file (VS Code Ctrl+Shift+L) |
| `<C-q>` | n | Put a cursor **here** and freeze the others, so you can walk to the next spot |
| `<Esc>` | n | Unfreeze the cursors if frozen, otherwise back to **one cursor** |

### Recipes

**1. Rename every occurrence of a word — or only some of them**

```
put the cursor on the word
<C-n> <C-n> <C-n>        one press per extra occurrence
ciw  newname  <Esc>      edit once → changed everywhere
<Esc>                    back to one cursor
```

- Landed on one you don't want? `<leader>ms` **skips** it: the main cursor
  jumps to the next match without keeping a cursor there.
- All of them at once: `<leader>ma` instead of the `<C-n>` presses.
- Going backwards: `<leader>mN` (add) and `<leader>mS` (skip).
- Matching is whole-word and case-sensitive: `<C-n>` on `foo` won't grab
  `foobar` or `Foo`. To match arbitrary text (`foo.bar`, part of a word),
  select it first (`v…`) and press `<C-n>` on the selection.
  - 0.12: each cursor keeps its own selection, so just press `c` to replace
    them all.
  - 0.13+: the cursors sit at the start of each match and the search is set
    to the text, so use `cgn` ("change match") instead of `c`.
- Only inside the current function: see recipe 6.

**2. Type at the start / end of many lines (column editing)**

```
V j j j   I  - <Space>  <Esc> <Esc>    "- " in front of 4 lines
V j j j   A  ;          <Esc> <Esc>    ";" at the end of 4 lines
```

Or build the column one line at a time with `<A-J>` `<A-J>` …, then use
**any** command: `i`, `a`, `I`, `A`, `ciw`, `dw`, `x`, `r`, `>>`, `~`, …
In visual-block mode (`<C-v>`), `I` / `A` insert at the block's column, the
same as always.

**3. One cursor per line of a motion — `ga`**

`ga` is an operator: `gaip` = a cursor on every line of the paragraph,
`ga4j` = this line and the next four, `gaG` = down to the end of the file.
In visual mode, `ga` puts a cursor on each selected line.

**4. Cursors in arbitrary places**

```
<C-q>          drop a cursor here (the others freeze)
move anywhere  w, j, /foo<CR>, f( … — only the main cursor moves
<C-q>          drop another one (on an existing cursor: removes it)
<Esc>          unfreeze → now edit; <Esc> again when done
```

With a mouse: **Ctrl+click** adds or removes a cursor (Ctrl+drag adds
several — 0.12 only).

**5. Cursors from a search**

`/pattern<CR>` then **`<leader>m/`** → a cursor on every match of the
search. Regexes work: `/\d\+` then `<leader>m/` = a cursor on every number.

**6. Only within a range**

- **0.12:** `<leader>mm` + *what to match* + *where*. `<leader>mm iw af` =
  every occurrence of the word under the cursor **inside this function**
  (`af` is the treesitter function text object); `<leader>mm iw ip` = inside
  the paragraph. From visual mode the selection is *what to match*; then give
  the range.
- **0.13+:** select the range first, then a cursor-placing motion:
  `vaf` (select function) then `<leader>m/` (regex prompt) — or use the
  built-in `zq`: `<leader>mm` = `zq{motion}`, e.g. `vip` `<leader>mm` `w`
  = a cursor at every word (every stop of `w`) in the paragraph.

**7. Regex inside a selection, or split a selection**

- Select something (e.g. a line), **`<leader>m/`**, type a regex, `<CR>`:
  a cursor on each match inside the selection. With `\w\+` that's every word.
  - 0.12: each cursor selects its match — press `c` to replace them.
  - 0.13+: press `gv` (selects the match at every cursor), then `c`.
- **0.12 only:** select `red, green, blue`, **`<leader>m|`**, type `, `,
  `<CR>` → three selections, one per item.

**8. Number things 1, 2, 3 …**

- **0.12:** cursors on lines that contain a number (e.g. `item 0` on four
  lines: `<A-J>` × 3), `$`, then **`g<C-a>`** → `item 1`, `item 2`,
  `item 3`, `item 4`. `g<C-x>` counts down; `10g<C-a>` steps by 10.
- **0.13+:** `g<C-a>` *inserts* 1, 2, 3, … at the cursors instead (built-in).
- Plain `<C-a>` / `<C-x>` add or subtract the same amount at every cursor.

**9. Line things up (0.12 only)**

Cursors in front of each `=` (`gaip`, then `f=`), then **`<leader>m=`**
pads with spaces so every cursor stands in the same column:

```
a = 1            a   = 1
bbb = 2    →     bbb = 2
cc = 3           cc  = 3
```

**10. Swap things around (0.12 only)** — with a selection at each cursor,
visual `<leader>mt` / `<leader>mT` rotates the selected texts one cursor
forward / backward. To swap two arguments: select `first, second`, split it
with `<leader>m|` and `, `, then `<leader>mt`.

### Full reference

**Adding cursors**

| Key | Mode | Action |
| --- | --- | --- |
| `<C-n>` or `<leader>mn` | n, v | Add a cursor at the next match of the word / selection |
| `<leader>mN` | n, v | Add a cursor at the previous match |
| `<leader>ms` / `<leader>mS` | n, v | Skip to the next / previous match (no cursor left behind) |
| `<leader>ma` | n, v | Add cursors at all matches in the file |
| `<A-J>` or `<leader>mj` | n (0.12: also v) | Add a cursor on the line below |
| `<A-K>` or `<leader>mk` | n (0.12: also v) | Add a cursor on the line above |
| `ga{motion}` | n, v | A cursor on every line of the motion / selection |
| `I` / `A` | v | Insert / append on every selected line |
| `<leader>m/` | n | A cursor on every match of the last `/` search |
| `<leader>m/` | v | A cursor on every regex match inside the selection (asks for the regex) |
| `<leader>mm` | n, v | 0.12: every match of {text object} inside {range} · 0.13+: `zq{motion}` |
| `<leader>m\|` | v | **0.12 only:** split the selection by a regex (asks for it) |
| `<C-q>` or `<leader>mc` | n (0.12: also v) | Add / remove a cursor here and freeze the others |
| Ctrl+click | n | Add / remove a cursor with the mouse (0.12: Ctrl+drag adds several) |
| `<leader>mr` | n | Restore the cursors you just cleared |

**Managing cursors**

| Key | Mode | Action |
| --- | --- | --- |
| `<Esc>` | n | Unfreeze the cursors if frozen, otherwise clear all extra cursors |
| `]c` / `[c` | n (0.12: also v) | Make the next / previous cursor the main one (the screen follows it) |
| `<leader>md` | n | 0.12: delete the main cursor · 0.13+: remove the cursor under the main cursor (use after `]c`) |
| `g<C-a>` / `g<C-x>` | n, v | 0.12: increment / decrement as a 1, 2, 3 … sequence · 0.13+: `g<C-a>` inserts 1, 2, 3 … |
| `<Right>` / `<Left>` | n, v | **0.12 only:** same as `]c` / `[c` (if your arrow keys work) |
| `<leader>m=` | n | **0.12 only:** align all cursors to one column |
| `<leader>mt` / `<leader>mT` | v | **0.12 only:** rotate the selected texts forward / backward |

On 0.12, `]c` `[c` `<Right>` `<Left>` `g<C-a>` `g<C-x>` and the
clear-on-`<Esc>` only exist **while you have extra cursors**, so they never
get in the way of normal editing (`]c` / `[c` are diff-mode "next / previous
change" the rest of the time). On 0.13+ `]c` / `[c` still do that when there
are no cursors.

### Good to know

- **Typing in insert mode.**
  - 0.12: you type at the main cursor; the other cursors get the same text the
    moment you press `<Esc>`.
  - 0.13+: the text appears at every cursor live as you type.
- **Moving inside insert mode.** Moving with `<Up>` / `<Down>` (or
  `<C-Insert>`) *inside* insert mode starts a new edit, so only what you type
  after that gets copied. Leave insert mode to move instead. `<Insert>` (move
  right) is fine.
- **Completion and auto-pairs work at every cursor.** Accept a completion
  with `<CR>`; brackets close themselves.
- **Undo is one step.** `u` and `<C-r>` act on all cursors at once.
  On 0.12, undo also brings back the cursors of that edit.
- **Frozen cursors** (after `<C-q>`) stay put while you move; the statusline
  says "(frozen)" and `<Esc>` unfreezes them.
  - 0.12: frozen cursors also ignore edits; only the main cursor works until
    you unfreeze.
  - 0.13+: edits still happen at every cursor.
- **which-key popups are switched off** while you have extra cursors on 0.12
  (the plugin does this on purpose). The keys still work; this page and the
  statusline counter are your guide.
- **Macros:** record as usual; `@q` with several cursors runs the macro at
  each one.
- **Switching windows clears the cursors** on 0.12. On 0.13+ they stay with
  their buffer and come back when you return to it.
- `<C-n>` in **insert** mode is still completion "next item". Multi-cursor
  only uses `<C-n>` in normal / visual mode.
- **Keys this takes over:**
  - `<C-q>` was a synonym for `<C-v>`; use `<C-v>`.
  - `ga` was `:ascii`; the command still works.
  - `<C-n>` in normal / visual mode was "line down", same as `j`.
  - Visual `I` / `A` now work on every selected line, not just the first. In
    block mode they behave exactly as before.

### Multi-cursor on Neovim 0.13+

Neovim 0.13 (in nightly builds today) adds multiple cursors to the editor
itself (`:h multicursor`). This config detects it (builds that have it also
have the `'follow'` option): multicursor.nvim stays installed but isn't
loaded, and the keys above are wired to the built-in cursors
(`lua/core/multicursor.lua`). An older 0.13-dev build without built-in cursors
simply keeps using the plugin. What changes for you:

| | 0.12 (plugin) | 0.13+ (built in) |
| --- | --- | --- |
| Typing at all cursors | after `<Esc>` | live |
| Editing while frozen (`<C-q>`) | only the main cursor | every cursor |
| Visual `<C-n>` then edit | `c` | `cgn` |
| Visual `<leader>m/` then edit | `c` | `gv` then `c` |
| `g<C-a>` | increments existing numbers 1, 2, 3 … | inserts 1, 2, 3 … |
| `<leader>mm` | match {text object} inside {range} | `zq{motion}` |
| `<leader>m=` `<leader>m\|` `<leader>mt` | yes | — |
| Arrow keys `<Left>` / `<Right>` cycle cursors | yes | — (`]c` / `[c`) |
| which-key popup while cursors exist | hidden | shown |

Built-in extras on 0.13+:

- `Q` toggles a cursor. **`Q` no longer replays the last macro** on 0.13;
  use `@@`.
- `zq{motion}` puts a cursor at every target of a motion: `zqw` every word,
  `zq*` every match of the word, `vipzqj` every line of the paragraph.
- `q=` toggles "follow": motions move every cursor or only the main one.
  `<C-q>` turns it off; the add-cursor keys turn it back on.
- `]C` / `[C` jump to the next / previous cursor.
- `gQ` restores the last cursors.
- `:h multicursor` has the full guide.

---

## Everyday editing

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>w` / `<leader>wa` | n | Save / save all |
| `<leader>q` / `<leader>qa` | n | Quit / quit all (asks before dropping unsaved changes) |
| `<Esc>` or `<leader>h` | n | Clear search highlight |
| `<leader>c` | n | Close buffer |
| `<A-j>` / `<A-k>` | n, v | Move line / selection down / up |
| `J` / `K` | v | Move selection down / up |
| `<` / `>` | v | Indent / outdent, keeping the selection |
| `j` / `k` | n, v | Down / up by **screen** line on wrapped text; with a count (`5j`) by real lines |
| `<leader>ss` | n | Substitute the word under the cursor in the whole buffer: the command line opens prefilled (`:%s/\<word\>/word/gI`) with the cursor on the replacement — edit it, `<CR>` |
| `<leader>qq` | n | Insert a Go `if err != nil { … }` block |
| `<Insert>` | i | Move right (e.g. past an auto-inserted `)`) without breaking undo / `.` |
| `<C-Insert>` | i | Move down |
| `gsa{motion}{char}` | n, v | **Add** surrounding: `gsaiw"` → `"word"`, `gsaiw)` → `(word)` |
| `gsd{char}` | n | **Delete** surrounding: `gsd"` |
| `gsr{old}{new}` | n | **Replace** surrounding: `gsr"'` |
| `gsf` / `gsF` / `gsh` | n | Find surrounding right / left · highlight it |
| `gcc` / `gc{motion}` | n, v | Toggle comment (built in): `gcc` line, `gcip` paragraph |
| `P` | v | Paste over the selection **without** losing what you yanked (built in) |
| `.` | n | Repeat the last change |

## Moving around

| Key | Mode | Action |
| --- | --- | --- |
| `s{1-2 chars}` | n, v, o | **flash** jump: type the start of the target, then the label that appears |
| `S` | n, v, o | flash treesitter: pick a syntax node (function, block, argument) by label |
| `r` | o | Remote flash: `yr…` yanks text somewhere else without moving |
| `R` | v, o | Treesitter search |
| `f` `F` `t` `T` `;` `,` | n, v, o | Enhanced by flash: work across lines, highlight the targets |
| `<C-s>` | while searching (`/`) | Toggle flash labels in the search |
| `<C-h/j/k/l>` | n | Move between windows |
| `<C-Up/Down/Left/Right>` | n | Resize the window |
| `H` / `L` | n | Previous / next buffer (also built-in `[b` / `]b`) |
| `gt` / `gT` | n | Next / previous tab |
| `<leader>L1` … `<leader>L9` | n | Go to tab N |
| `<leader>Ln` / `Lc` / `Lo` | n | New tab / close tab / close all other tabs |
| `]f` / `[f` | n, v, o | Next / previous function (treesitter) |
| `]a` / `[a` | n, v, o | Next / previous parameter |
| `]r` / `[r` | n | Next / previous reference of the symbol under the cursor (LSP) |
| `]t` / `[t` | n | Next / previous TODO / FIXME comment |
| `]h` / `[h` · `]H` / `[H` | n | Next / previous git hunk · last / first hunk |
| `]d` / `[d` · `]e` / `[e` · `]w` / `[w` | n | Next / previous diagnostic · error only · warning only |
| `]q` / `[q` | n | Next / previous quickfix item (built in) |
| `<C-o>` / `<C-i>` | n | Jump back / forward (jumplist) |
| `za` · `zR` / `zM` | n | Toggle fold · open / close all folds (treesitter folds, all open by default) |

**Text objects** (after `d`, `c`, `y`, `v`, …): `af` / `if` function,
`ac` / `ic` class, `aa` / `ia` parameter, `ih` git hunk, and built-in
`an` / `in` (grow / shrink by syntax node — `van` `an` `an` …).

## Find (pickers)

| Key | Action |
| --- | --- |
| `<leader>ff` / `fg` / `fz` | Files / live grep / fuzzy grep (fff) |
| `<leader>fw` | Grep the word under the cursor (for a selection: visual `<leader>sg`) |
| `<leader>fb` / `fr` / `fh` | Buffers / recent files / help pages |
| `<leader>fk` / `fc` | **All keymaps** / commands |
| `<leader>fs` / `fS` | Document / workspace symbols (LSP) |
| `<leader>fd` | Diagnostics |
| `<leader>f/` | Lines of the current buffer |
| `<leader>fu` | Undo history (jump to any earlier state) |
| `<leader>ft` | TODO / FIXME comments |
| `<leader>fj` / `fm` / `f"` | Jumplist / marks / registers |
| `<leader>fq` | Quickfix list |
| `<leader>fn` | Notification history (missed a message? it's here) |
| `<leader>fH` | Highlight groups |
| `<leader>fR` | Resume the last picker |

Inside a picker: type to filter · `<C-n>` / `<C-p>` move · `<CR>` open ·
`<C-s>` / `<C-v>` / `<C-t>` open in split / vsplit / tab · `<Tab>` select
several · `<C-q>` send to quickfix · `<Esc>` close.

## LSP / code

Active in buffers with a language server attached.

| Key | Mode | Action |
| --- | --- | --- |
| `gd` / `gD` | n | Definition / declaration |
| `gr` | n | References |
| `gi` / `gt` | n | Implementation / type definition |
| `K` | n | Hover documentation (press again to jump into it) |
| `gK` / `<C-s>` | n / i | Signature help |
| `<leader>rn` | n | Rename symbol across the project |
| `<leader>rf` | n | Rename the current file — the LSP updates imports |
| `<leader>ca` | n, v | Code actions; in visual mode for the selection (e.g. "extract function") |
| `<leader>f` | n, v | Format buffer / selection (also on save — see `<leader>uf`) |
| `gO` | n | Document symbols in the location list (built in) |
| `<leader>uh` | n | Toggle inlay hints |

Neovim's own `grn` `gra` `grr` `gri` `grt` `grx` are shadowed in LSP
buffers by the instant `gr`. Use `<leader>rn`, `<leader>ca`, `gr`, `gi`,
`gt` instead.

## Diagnostics & lists

| Key | Action |
| --- | --- |
| `<leader>xx` / `<leader>xX` | Project / buffer diagnostics (Trouble) |
| `<leader>xs` | Symbols outline |
| `<leader>xq` / `<leader>xl` | Quickfix / location list |
| `<leader>xt` | TODOs |
| `<leader>xd` | Diagnostic under the cursor in a float (also built-in `<C-w>d`) |
| `]d` `[d` · `]e` `[e` · `]w` `[w` | Jump: any diagnostic · errors · warnings |

## Git

| Key | Mode | Action |
| --- | --- | --- |
| `]h` / `[h` · `]H` / `[H` | n | Next / previous hunk · last / first |
| `<leader>ga` | n / v | Stage (or unstage) the hunk / **only the selected lines** |
| `<leader>gr` | n / v | Reset the hunk / only the selected lines |
| `<leader>gS` / `<leader>gR` | n | Stage / reset the whole file |
| `<leader>gp` / `<leader>gi` | n | Preview the hunk in a float / inline |
| `<leader>gb` / `<leader>gB` | n | Blame this line / toggle inline blame |
| `ih` | o, v | Hunk text object (`dih`, `vih`) |
| `<leader>gs` | n | **Neogit**: stage, commit, push, pull, branch, rebase, stash … |
| `<leader>gd` / `<leader>gq` | n | Diffview: diff of the working tree / close |
| `<leader>gh` / `<leader>gH` | n | History of this file / of the branch |
| `<leader>gm` | n | Resolve merge conflicts (3-way view) |
| `<leader>gl` / `<leader>gL` | n | Git log picker / history of the current line |
| `<leader>go` | n, v | Open the file (or the selected lines) on GitHub / GitLab |

## Search & replace, sessions

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>sr` | n, v | Project search & replace with live preview (grug-far, limited to this file type) |
| `<leader>sw` | n | … prefilled with the word under the cursor |
| `<leader>ss` | n | Substitute the word under the cursor in this buffer |
| `<leader>sg` | v | Grep the selected text in the project |
| `<leader>qs` / `ql` / `qd` | n | Restore this folder's session / the last session / stop saving |

## Debug (`<leader>d`)

| Key | Action |
| --- | --- |
| `<leader>db` / `dB` | Toggle / conditional breakpoint |
| `<leader>dc` or `<F5>` | Continue / start |
| `<leader>dC` | Run to cursor |
| `<leader>di` `<F11>` / `dO` `<F10>` / `do` `<F12>` | Step into / over / out |
| `<leader>de` | Evaluate the expression under the cursor / the selection |
| `<leader>dr` / `dl` / `dt` | REPL / run last / terminate |
| `<leader>du` | Toggle the debugger UI |

## Test (`<leader>t`)

| Key | Action |
| --- | --- |
| `<leader>tt` / `tf` / `ta` | Run nearest / file / all (current folder) |
| `<leader>td` | Debug the nearest test |
| `<leader>tl` / `tS` | Run last / stop |
| `<leader>ts` / `to` / `tO` | Summary tree / output / output panel |
| `<leader>tw` | Watch this file |

## Completion (insert mode)

| Key | Action |
| --- | --- |
| `<CR>` | Accept |
| `<Tab>` / `<S-Tab>` | Next / previous item, or jump between snippet fields |
| `<C-n>` / `<C-p>` · `<Down>` / `<Up>` | Next / previous item |
| `<C-Space>` | Open the menu / toggle documentation |
| `<C-e>` | Close the menu |
| `<C-d>` / `<C-f>` | Scroll documentation up / down (`<C-b>` also scrolls up) |
| `<C-k>` | Toggle signature help |

Completion also works on the `:` command line (`<Tab>` to complete).

## UI toggles (`<leader>u`)

which-key shows the current on/off state next to each toggle.

| Key | Toggle |
| --- | --- |
| `<leader>us` `uw` `ur` `ul` | Spelling · wrap · relative numbers · line numbers |
| `<leader>ud` `uh` `ug` | Diagnostics · inlay hints · indent guides |
| `<leader>uT` `uc` `ub` | Treesitter highlighting · conceal · dark / light background |
| `<leader>uf` / `uF` | Format on save — everywhere / this buffer only |
| `<leader>uz` / `uZ` | Zen mode / zoom (maximise) the current window |
| `<leader>ui` / `uI` | Inspect the highlight under the cursor / the syntax tree |

## Terminal & tools

| Key | Mode | Action |
| --- | --- | --- |
| `<C-/>` | n, t | Toggle a floating terminal (terminals that send `<C-_>` work too) |
| `<Esc><Esc>` | t | Leave terminal mode in the floating terminal |
| `<C-\><C-n>` | t | Leave terminal mode in any terminal |
| `<leader>l` | n | Lazy plugin manager (`U` update, `S` sync, `X` clean) |
| `:Mason` | | Install / update language servers and tools |
| `<leader>e` · `<leader>wl` | n | Netrw: current folder · toggle left explorer |
| `<leader>HS` / `<leader>VS` / `<leader>nt` | n | Netrw in a horizontal / vertical split / new tab |

## Built into Neovim (no plugin needed)

Worth knowing — they work out of the box on 0.12.

| Key | Mode | Action |
| --- | --- | --- |
| `an` / `in` | v, o | Grow / shrink the selection by syntax node (`van` `an` `an` …) |
| `]n` / `[n` · `]N` / `[N` | v | Select the next / previous node · next / previous sibling node |
| `gcc` / `gc` | n, v | Toggle comment |
| `gx` | n, v | Open the URL / file under the cursor |
| `<C-w>d` | n | Diagnostic under the cursor in a float |
| `]<Space>` / `[<Space>` | n | Add an empty line below / above |
| `]q` `[q` `]Q` `[Q` | n | Quickfix: next / previous / last / first (`]l` … for the location list) |
| `]b` / `[b` | n | Next / previous buffer |
| `*` / `#` | v | Search forward / backward for the selected text |
| `Y` | n | Yank to the end of the line |
| `&` | n | Repeat the last `:s` with its flags |
| `<C-a>` / `<C-x>` · `g<C-a>` | n · v | Increment / decrement a number · visual: make a 1, 2, 3 … sequence |
| `gv` | n | Reselect the last selection |
| `<C-r>{register}` | i | Insert a register (`<C-r>"` last yank, `<C-r>+` system clipboard) |
| `<C-o>{command}` | i | Run one normal-mode command, then continue typing |
| `<C-w>` / `<C-u>` | i | Delete the word / everything before the cursor |
| `Q` | n | 0.12: replay the last macro · 0.13+: toggle a cursor (use `@@` to replay) |

## Keys that differ from stock Vim

| Key | Here | Stock Vim |
| --- | --- | --- |
| `s` / `S` | flash jump / treesitter select | substitute char / line — use `cl` / `cc` |
| `H` / `L` | previous / next buffer | top / bottom of the screen |
| `<C-h/j/k/l>` | window navigation | `<C-l>` redraws; `<Esc>` clears the highlight instead |
| `j` / `k` | move by screen line on wrapped text | move by real line |
| `<C-n>` `<C-q>` `ga` · visual `I` `A` | multi-cursor | line down · block select · `:ascii` · first line only |
| `]t` / `[t` · `]a` / `[a` | TODOs · parameters | tags · argument list |
| `gs` | surround prefix | sleep |
| `gr` `gi` `gt` `gd` `gD` `K` | LSP (in code buffers) | — |
| `<Esc>` | also clears the search highlight (and multi-cursors) | — |

## Troubleshooting keys

- **Alt keys do nothing** (`<A-j>`, `<A-J>`, …): your terminal has to send
  Alt as "Meta". GNOME Terminal, Kitty, WezTerm, Alacritty and Ghostty do this
  by default. On macOS turn on "Use Option as Meta key" (Terminal.app),
  `macos_option_as_alt` (Kitty) or "Left Option key: Esc+" (iTerm2). No Alt
  at all? `<leader>mj` / `<leader>mk` do what `<A-J>` / `<A-K>` do.
- **Arrow keys broken?** Nothing here depends on them: every multi-cursor
  action has a letter or Alt key. In insert mode, `<Insert>` moves right and
  `<C-Insert>` moves down.
- **Ctrl+click adds no cursor:** some terminals use Ctrl+click to open links;
  plain text still works. Mouse support is on by default in Neovim.
- **`<C-/>` does nothing:** most terminals send it as `<C-_>`, which is
  mapped too; `:lua Snacks.terminal()` is the fallback.
- **`<leader>w`, `<leader>c`, `<leader>f`, `<leader>q` feel slow:** each is a
  command *and* the start of longer ones (`<leader>wl`, `<leader>ca`,
  `<leader>ff`, `<leader>qs`), so Neovim waits 0.4 s for more keys. Type the
  whole sequence quickly and it's instant.
- **Can't remember a key:** `<leader>fk`, then type part of what it does.
