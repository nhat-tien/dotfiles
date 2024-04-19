return {
	"Hoffs/omnisharp-extended-lsp.nvim",
	lazy = true,
	ft = {
		"razor",
		"c_sharp",
	},
	config = function()
		require("lspconfig").omnisharp.setup({
			cmd = { "dotnet", "/home/nhattien/lsp/omnisharp/OmniSharp.dll" },
			handlers = {
				["textDocument/definition"] = require("omnisharp_extended").definition_handler,
				["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
				["textDocument/references"] = require("omnisharp_extended").references_handler,
				["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
			},
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
		})
	end,
}
