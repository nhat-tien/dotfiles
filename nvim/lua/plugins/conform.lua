-- Formatter
return {
	"stevearc/conform.nvim",
	opts = {},
   event = "LspAttach",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				php = { "php_cs_fixer" },
				lua = { "stylua" },
				dart = { "dart_format" },
			},
		})
	end,
}
