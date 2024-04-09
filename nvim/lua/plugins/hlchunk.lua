return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		require("hlchunk").setup({
			blank = {
				enable = false,
			},
		})
	end,
}
