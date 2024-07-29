return {
	"nvim-neorg/neorg",
	ft = "norg",
	cmd = "Neorg",
	dependencies = {
		{
			"nvim-neorg/lua-utils.nvim",
			lazy = true,
		},
		{
			"pysan3/pathlib.nvim",
			lazy = true,
		},
	},
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/NotesVaults/neorg/",
						},
                  default_workspace = "notes"
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
}
