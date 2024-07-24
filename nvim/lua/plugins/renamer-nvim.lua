return {
	"filipdutescu/renamer.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("renamer").setup()
	end,
}
