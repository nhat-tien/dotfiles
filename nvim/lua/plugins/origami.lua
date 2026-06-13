return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {},

	-- recommended: disable vim's auto-folding
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
