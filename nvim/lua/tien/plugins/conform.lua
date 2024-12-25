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
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescrip = { "prettierd" },
				typescriptreact = { "prettierd" },
				yaml = { "prettierd" },
				vue = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				sh = { "beautysh" },
            markdown = { "prettierd"},
            cs = {"csharpier"}
			},
			-- format_on_save = {
			-- 	lsp_format = "fallback",
			-- 	timeout_ms = 500,
			-- },
		})
	end,
}
