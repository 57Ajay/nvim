-- ~/.config/nvim/lua/plugins/completion.lua
-- blink.cmp replaces nvim-cmp + LuaSnip + the cmp-* sources with one fast,
-- batteries-included plugin (LSP, path, snippets, buffer, signature help).
return {
    "saghen/blink.cmp",
    version = "1.*", -- v2 is in active development with breaking changes; stay on stable v1
    event = "InsertEnter",
    dependencies = { "folke/lazydev.nvim" },
    opts = {
        appearance = { nerd_font_variant = "mono" },

        -- Keymap mirrors your old nvim-cmp habits:
        --   <CR> confirm · <Tab>/<S-Tab> cycle items + jump snippets
        --   <C-Space> toggle menu/docs · <C-d>/<C-f> scroll docs · <C-e> hide
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-d>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            ghost_text = { enabled = true },
        },

        signature = { enabled = true },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            providers = {
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
            },
        },

        -- Rust fuzzy matcher (prebuilt binary ships with the release).
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
