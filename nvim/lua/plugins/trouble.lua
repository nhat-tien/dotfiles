return {
	"folke/trouble.nvim",
	keys = {
		{
			"<leader>d",
			function()
				require("trouble").toggle("diagnostics")
			end,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
}
