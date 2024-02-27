require("config.options")

-- Lazy
require("config.lazy-nvim")

-- Appearance
require("config.ui")

-- Keymap
require("config.keymaps")

-- Plugin Config
require("plugins.treesitter")
require("plugins.nvim-tree-config")
require("plugins.comment")
require("plugins.luasnip-config")
require("plugins.mini-pairs")
require("plugins.mini-surround")
require("plugins.indent")
require("plugins.gitsigns")
require("plugins.telescope-config")
require("plugins.wilder-config")

-- LSP 
require("lsp.main")
