-- ~/.config/nvim/lua/core/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Every file under lua/plugins/ that returns a spec is auto-collected.
require("lazy").setup({
    { import = "plugins" },
}, {
    install = { colorscheme = { "tokyonight" } }, -- used during fresh `Lazy sync`
    checker = { enabled = true, notify = false }, -- background update checks
    rocks = { enabled = false },
    change_detection = { notify = false },
    ui = { border = "rounded" },
    performance = {
        rtp = {
            -- NOTE: netrwPlugin is deliberately NOT in this list — you use netrw.
            disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
        },
    },
})
