return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	ft = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"php",
		"vue",
		"markdown",
		"xml",
	},
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
