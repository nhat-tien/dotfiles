return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	lazy = true,
	ft = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"php",
		"vue",
	},
	config = function()
		require("ts_context_commentstring").setup({})
	end,
}
