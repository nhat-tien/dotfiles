return {
	"folke/trouble.nvim",
	keys = {
		{
			"<leader>d",
			function()
				require("trouble").toggle()
			end,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
}
