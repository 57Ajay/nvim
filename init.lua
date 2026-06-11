-- ~/.config/nvim/init.lua
-- Requires Neovim 0.12+ (nvim-treesitter `main`, vim.lsp.config/enable, vim.hl).
-- Load order matters: options/keymaps/autocmds before the plugin manager.

if vim.fn.has("nvim-0.12") ~= 1 then
    vim.api.nvim_echo({
        { "This config requires Neovim 0.12 or newer.\n", "ErrorMsg" },
        { "Install the latest stable: https://github.com/neovim/neovim/releases\n", "MoreMsg" },
    }, true, {})
    return
end

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
