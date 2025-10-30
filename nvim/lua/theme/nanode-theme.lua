local M = {}

M.dark_theme_setup = function()
    require("nanode").setup({
      transparent = false,
    })
    vim.cmd.colorscheme("nanode")
end

M.light_theme_setup = function()
    require("nanode").setup({
      transparent = false,
    })
    vim.cmd.colorscheme("nanode")
end

M.colors = require("nanode.palette").colors

return M

