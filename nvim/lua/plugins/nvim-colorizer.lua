return {
	"norcalli/nvim-colorizer.lua",
	lazy = true,
	ft = {
		"css",
		"toml",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	config = function()
		require("colorizer").setup({
			"css",
			"toml",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		})
	end,
}
