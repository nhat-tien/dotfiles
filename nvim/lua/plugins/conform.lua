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
            rust = { "rustfmt" },
            java = { "google-java-format" },
            javascript = { "prettierd"},
            javascriptreact = { "prettierd"},
            typescrip = { "prettierd"},
            typescriptreact = { "prettierd"},
            html = { "prettierd"},
            css = { "prettierd"},
			},
		})
	end,
}
