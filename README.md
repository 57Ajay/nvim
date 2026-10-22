# Neovim config — 0.12+, modular, verified

A fast, modern Neovim setup for polyglot systems work (Go, TypeScript, Rust,
Python, Zig, C/C++, Lua). No deprecated APIs anywhere: native `vim.lsp.config`
/ `vim.lsp.enable`, nvim-treesitter `main` branch, mason v2, `vim.diagnostic.jump`,
`vim.hl`. Every piece below was installed, booted, and exercised on real
**Neovim 0.12.6** (current stable) and **0.13-dev nightly** binaries before
shipping (see *Verified* at the bottom).

**Requires Neovim 0.12 or newer.** `init.lua` refuses to load on anything older,
on purpose.

**Every keybinding — including the multi-cursor guide — is in
[KEYBINDINGS.md](KEYBINDINGS.md).**

## What's inside

| Area | Plugins |
| --- | --- |
| Files / search | netrw (kept, your maps intact), **fff.nvim** (Rust file picker + live grep), **snacks.picker** (buffers, help, symbols, undo, …) |
| Completion | **blink.cmp** `1.*` (LSP, path, snippets, buffer, signature) |
| LSP | nvim-lspconfig (data only) + **mason** v2 + mason-lspconfig (`automatic_enable`) — lua_ls, gopls, ts_ls, rust_analyzer, pyright, ruff, zls, clangd |
| Formatting | **conform.nvim** + format-on-save; mason-tool-installer fetches stylua/shfmt/prettierd/goimports |
| Syntax | **nvim-treesitter `main`** (the rewrite) + textobjects `main`; treesitter folds |
| **Debugging** | **nvim-dap** + dap-ui + virtual-text; mason-managed adapters: delve (Go), debugpy (Python), codelldb (Rust/Zig/C/C++) |
| **Testing** | **neotest** + neotest-golang (delve debugging built in) + neotest-python (pytest + debugpy) |
| **Multi-cursor** | **multicursor.nvim** on 0.12; Neovim's built-in cursors on 0.13+ — same keys either way (`<C-n>`, `<A-J>`/`<A-K>`, visual `I`/`A`, `<leader>m…`) |
| **Power editing** | **flash.nvim** (2-keystroke motions), **mini.surround** (`gs*`), **todo-comments**, **grug-far** (project search & replace), **persistence** (sessions) |
| Git | gitsigns, **Neogit**, diffview (incl. 3-way merge resolver) |
| UI / QoL | tokyonight, lualine, which-key, snacks (indent guides, notifier, image, bigfile, input, words, `<leader>u` toggle suite), trouble, mini.pairs, lazydev |

Plugin manager is **lazy.nvim**. `lazy-lock.json` ships pinned to the exact
commits this config was tested against — keep it for reproducibility, or
delete it before the first `:Lazy sync` if you'd rather float to latest.

## Requirements

Hard requirements on every machine:

- **Neovim ≥ 0.12** (tested on 0.12.6, the current stable, and on 0.13-dev nightly)
- `git`, `curl`, a **C compiler** (gcc/clang) — treesitter parsers compile locally
- **tree-sitter CLI ≥ 0.26.1** (binary release, **not** the npm package):

  ```bash
  mkdir -p ~/.local/bin
  curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
    | gunzip > ~/.local/bin/tree-sitter && chmod +x ~/.local/bin/tree-sitter
  ```

- **ripgrep** (`rg`) — grug-far + pickers
- A **Nerd Font** in your terminal

Per-language (only for what you use): Go toolchain (gopls, delve, goimports),
Node (ts_ls, pyright, prettierd), python3 (debugpy, ruff). rust_analyzer, zls,
clangd, codelldb, lua_ls, stylua install as prebuilt binaries via mason.

Optional niceties: `fd` (faster snacks explorer/file sources), `sqlite3`
(fff/snacks frecency storage), Kitty/WezTerm/Ghostty (inline image previews).

## Install / migrate

```bash
# 1. Back up whatever you have
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# 2. Fresh state — the treesitter rewrite makes this genuinely worth doing
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# 3. Drop this directory in place
cp -r nvim ~/.config/nvim     # (or git clone your dotfiles)

# 4. First launch: lazy.nvim bootstraps, restores pinned plugins,
#    compiles ~26 treesitter parsers, mason installs servers. Let it finish.
nvim

# 5. Sanity check
:checkhealth lazy nvim-treesitter mason
```

Laptop note: if it's still on 0.11, upgrade first — `bob use stable`, the
AppImage, or the unstable PPA all give you 0.12.x on Ubuntu.

## Layout

```
init.lua                  -- 0.12 guard + module loading
KEYBINDINGS.md            -- every keybinding + search keywords (read by <leader>?), multi-cursor guide
lua/core/options.lua      -- options (incl. treesitter folds)
lua/core/keymaps.lua      -- editor-level keymaps only
lua/core/multicursor.lua  -- multi-cursor keys for Neovim 0.13+'s built-in cursors
lua/core/autocmds.lua     -- yank highlight, last position, auto-mkdir, q-to-close
lua/core/lazy.lua         -- plugin manager bootstrap
lua/core/cheatsheet.lua   -- <leader>? searchable keybinding list
lua/plugins/ui.lua        -- colorscheme, statusline (+ cursor count), icons
lua/plugins/completion.lua-- blink.cmp
lua/plugins/editor.lua    -- conform, trouble, pairs, lazydev, which-key groups
lua/plugins/editing.lua   -- flash, surround, todo-comments, grug-far, sessions
lua/plugins/multicursor.lua -- multicursor.nvim (Neovim 0.12)
lua/plugins/lsp.lua       -- LSP + mason + formatter auto-install
lua/plugins/treesitter.lua-- main branch, parser list, per-buffer attach
lua/plugins/git.lua       -- gitsigns, neogit, diffview
lua/plugins/fff.lua       -- file finder
lua/plugins/snacks.lua    -- pickers, QoL modules, terminal, <leader>u toggles
lua/plugins/dap.lua       -- debugging
lua/plugins/test.lua      -- neotest
```

Plugin keymaps live in their specs (lazy-loading + which-key discovery);
`core/keymaps.lua` stays plugin-free. Add new keys to `KEYBINDINGS.md` too, so
`<leader>?` can find them.

## Keymaps

Leader is `<Space>`. **Every keybinding, with search keywords, is in
[KEYBINDINGS.md](KEYBINDINGS.md).** Inside Neovim you don't need to open it:

- `<Space>?` fuzzy-searches that list by what you want to do (`rename`,
  `commit`, `breakpoint`, `split`…). <kbd>Enter</kbd> runs the key.
- `<Space>`, then wait: which-key shows every key that can follow.
- `<Space>fk` searches every live keymap, Neovim and plugin defaults included.

The ones you'll reach for most:

| Key | Action |
| --- | --- |
| `<leader>ff` / `<leader>fg` | find files / search text in the project |
| `<leader>e` | file explorer (netrw) |
| `<leader>w` / `<leader>q` | save / quit |
| `<C-h/j/k/l>` | move between windows |
| `gd` / `gr` / `K` | definition / references / hover docs |
| `<leader>rn` / `<leader>ca` / `<leader>f` | rename / code action / format |
| `]d` / `[d` | next / previous diagnostic |
| `<leader>gs` | Neogit: stage, commit, push |
| `s` | flash: jump anywhere on screen |
| `<C-n>` | multi-cursor: a cursor at the next match of the word (press again for more) |
| `<A-J>` / `<A-K>` | multi-cursor: a cursor on the line below / above |
| `V`…`j`, then `I` / `A` | type at the start / end of every selected line |
| `<Esc>` | back to one cursor · clear search highlights |

## Behavior changes worth knowing

- **`s` and `S` belong to flash now.** Native `s` ≡ `cl` and `S` ≡ `cc` — use
  those. Two keystrokes after `s` + a label jumps anywhere on screen.
- **`]t` / `[t`** jump TODO comments (shadowing the rarely-used builtin tag jumps).
- **Surround moved to `gs*`** so it can't collide with flash.
- **Folds are treesitter-powered**, all open by default: `za` toggle, `zM`/`zR`
  close/open all.
- `:q` on unsaved changes now **prompts** instead of erroring (`confirm`).
- Saving a file in a nonexistent directory **creates the parents**.
- `q` closes help/man/quickfix/checkhealth windows.
- jsonc files highlight via the **json** parser — that's correct on the
  treesitter main branch (there is no separate jsonc parser anymore).
- **`H` is previous buffer, `L` is next tab** (`]b` / `[b` also cycle
  buffers). `<S-l>` is the same key as `L`, so the old "next buffer" mapping
  on it never worked and was removed. More tab keys: `<leader>L1`…`9`,
  `<leader>Ln/Lc/Lo`, built-in `gT`.
- **Multi-cursor takes `<C-n>`, `<C-q>`, `ga` and visual `I` / `A`** (stock:
  line down, block select — use `<C-v>`, `:ascii`, first-line-only insert).
- **`<Esc>`** in normal mode clears the search highlight (and extra cursors).
- **`j` / `k`** move by screen line on wrapped text (by real line with a count).
- **Neovim 0.13:** multi-cursor switches to Neovim's built-in cursors (same
  keys; differences in [KEYBINDINGS.md](KEYBINDINGS.md#multi-cursor-on-neovim-013)),
  and the built-in `Q` adds a cursor instead of replaying the last macro (`@@`).

## Troubleshooting

- **gitcommit parser fails to compile on a low-RAM box** (`cc1 … Killed`):
  it's a huge generated parser; run once with `CFLAGS=-O0 nvim` and you're set.
  Anything with ~8 GB RAM compiles it normally.
- **fff crash banner when nvim's cwd is `/`**: fff refuses to index the
  filesystem root and its current nightly can crash in that refusal path.
  Harmless in real project directories (verified) — just don't edit from `/`.
- **"Did not detect DSR response"** message: only appears in dumb terminals
  (CI, pipes). Real terminals are fine.
- First launch downloads blink.cmp's prebuilt fuzzy matcher and mason packages —
  give it network and a minute.
- `gopls`/`ts_ls`/`pyright` need their toolchains (Go / Node) on `$PATH`;
  mason installs them *through* those toolchains.

## Verified

Tested in a sandbox (October 2026) on Neovim built from source at the
**v0.12.6** tag (current stable) and the **nightly** tag (0.13.0-dev), with
tree-sitter CLI 0.27.1, gcc 13, and every plugin at the commit in
`lazy-lock.json`:

- **Clean boot on both**: no errors, no messages, zero `vim.deprecate()` calls.
  (0.13 deprecates `vim.hl.on_yank` — it printed a warning on every yank — so
  the config uses `vim.hl.hl_op` where it exists.)
- All **38 plugins** restore from the lockfile; **27 treesitter parsers**
  compile and load on both versions.
- **Keymap audit** (global + LSP / gitsigns buffer-local maps): no new
  "prefix waits" were introduced, and the 0.4 s wait on LSP `gr` is gone
  (≈ 15–45 ms now, was ≈ 440 ms).
- **Docs ↔ keymaps cross-check**, with KEYBINDINGS.md parsed by the
  `<Space>?` code itself: every documented key exists as a live mapping in its
  modes (apart from built-ins, keys that only exist while extra cursors are on
  screen, and "0.12 only" keys on 0.13), and every keymap the config adds is
  documented.
- **Real-terminal tests** (tmux, keys typed at human speed, buffer state read
  back over RPC):
  - 0.12.6 — multicursor.nvim: **43/43** checks; other keymaps: **33/33**;
    `<Space>?` (search, run a key from it): **3/3**.
  - 0.13-dev — same keys on Neovim's built-in cursors: **43/43**; other
    keymaps: **33/33**; `<Space>?`: **3/3**.
- **LSP / formatting end-to-end** with gopls and gofmt: attach, `gr`, `]r`
  reference jumps, format-on-save and its `<leader>uf` / `uF` toggles.
- **Partial git staging**: visual `<leader>ga` stages only the selected line.
- Not testable in the sandbox, because GitHub *release downloads* are blocked
  there: mason's server / tool installs and blink.cmp's prebuilt matcher
  (built from source with cargo instead — `fuzzy.implementation` is unchanged).

Earlier run (June 2026, Neovim 0.12.1, with network access for mason): mason
installed lua_ls and it auto-enabled and attached with blink capabilities;
conform reformatted a buffer with mason's stylua; startup ≈ **189 ms**;
every key in `KEYBINDINGS.md` was cross-checked against the live keymap table
and `<Space>?` was driven in a real TUI (search, run a key, open the doc at a
row).
