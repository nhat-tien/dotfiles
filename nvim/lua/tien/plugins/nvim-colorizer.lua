return {
	"norcalli/nvim-colorizer.lua",
	lazy = true,
	ft = {
		"css",
      "scss",
		"toml",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
      "kdl",
	},
	config = function()
		require("colorizer").setup({
			"css",
         "scss",
			"toml",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
         "kdl",
		}, { css = true })
	end,
}
