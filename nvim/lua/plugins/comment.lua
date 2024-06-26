return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup({
			toggler = {
				---Line-comment toggle keymap
				line = "<C-c>",
				---Block-comment toggle keymap
				block = "gbc",
			},
			opleader = {
				---Line-comment keymap
				line = "<C-c>",
				---Block-comment keymap
				block = "gb",
			},
		})
	end,
}
