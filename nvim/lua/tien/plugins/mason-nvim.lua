-- return {}
return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = {
				exclude = {
					"jdtls",
					"harper_ls",
				},
			},
		})
	end,
}
