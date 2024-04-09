return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			rename = {
				keys = {
					quit = "<esc>",
				},
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
