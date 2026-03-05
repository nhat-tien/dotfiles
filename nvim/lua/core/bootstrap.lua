local M = {}

M.setup = function ()
   local config = require("config.local")
   print(config.mode)

   require("config.options")
   require("config.autocmd")
   require("core.setup_keymap").init()
   require("core.setup_lazynvim")
   require("core.setup_neovide")
   require("core.setup_ui")
   require("core.setup_lsp")
   require("core.setup_dap")
end

return M
