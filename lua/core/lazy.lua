-- ~/.config/nvim/lua/core/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim (vim.uv with vim.loop fallback)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    checker = { enabled = true, notify = false }, -- background update checks
    rocks = { enabled = false },
    change_detection = { notify = false },
    ui = { border = "rounded" },
})
