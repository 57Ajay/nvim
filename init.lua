-- ~/.config/nvim/init.lua
-- Load order matters: options/keymaps/autocmds before the plugin manager.
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
