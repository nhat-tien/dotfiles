require("regular-config")

-- Lazy
require("lazynvim")

-- Appearance
require("appearance")

-- Keymap
require("keys.regular")
require("keys.telescope-keymap")

-- Plugin Config
require("plugins.treesitter")
require("plugins.comment")
require("plugins.luasnip-config")
require("plugins.mini-pairs")
require("plugins.mini-surround")
require("plugins.ts-autotag")
require("plugins.ts-contex-commentstring")
require("plugins.colorizer")
require("plugins.indent")
require("plugins.gitsigns")
require("plugins.telescope-config")

-- LSP 
require("lsp.main")



