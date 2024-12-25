return {
	"akinsho/flutter-tools.nvim",
   enabled = function ()
      return require("tien.core.setuplang").isNeed("flutter")
   end,
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	ft = {
		"dart",
	},
	config = function()
		require("flutter-tools").setup({
			lsp = {
				color = { -- show the derived colours for dart variables
					enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
					background = true, -- highlight the background
					background_color = { r = 19, g = 17, b = 24}, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
					foreground = false, -- highlight the foreground
					virtual_text = false, -- show the highlight using virtual text
					virtual_text_str = "■", -- the virtual text character to highlight
				},
			},
		})
	end,
}
