local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
		"lua",
		"css",
		"scss",
		"typescript",
		"tsx",
		"javascript",
		"jsdoc",
		"json",
		"html",
		"rust",
		"go",
		"markdown",
      "markdown_inline",
		"vue",
		"php",
		"phpdoc",
		"toml",
      "python",
		"vim",
		"vimdoc",
		"dart",
		"java",
      "yaml",
      "typst",
      "cpp",
      "regex",
	},
  sync_install = true,
  highlight = { enable = true },
  incremental_selection = {
   enable = true
  },
  indent = { enable = true },
})

