require("core.options")

require("core.keymaps")

require("core.lazynvim")

require("core.ui")

-- Keymap require plugins
require("core.keymaps-plugin")

-- Plugin Config
require("plugins.treesitter")
require("plugins.nvim-tree-config")
require("plugins.telescope-config")

-- LSP
require("lsp.main")

