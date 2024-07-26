return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>-",
			function()
				require("yazi").yazi()
			end,
			desc = "Open the file manager",
		},
		{
			"<leader>y",
			function()
				require("yazi").yazi(nil, vim.fn.getcwd())
			end,
			desc = "Open the file manager in nvim's working directory",
		},
	},
	opts = {
		open_for_directories = false,
	},
}
