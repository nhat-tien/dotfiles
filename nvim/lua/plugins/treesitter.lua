local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {"lua","css", "scss", "typescript", "tsx", "javascript", "jsdoc", "json", "html", "rust", "go", "markdown", "vue", "php", "phpdoc", "toml", "python","vim", "vimdoc"},
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

