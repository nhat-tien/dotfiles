local M = {}

function M.setup()
   require("core.setup_keymap").init()
   require("core.setup_lazynvim")
   require("core.setup_ui")
   require("core.setup_lsp")
   require("core.setup_dap")
end

return M
