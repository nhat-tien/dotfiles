-- return {}
return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").filetype_extend("dart", { "flutter" })
		require("luasnip").filetype_extend("vue", { "vue" })
		require("luasnip").filetype_extend("blade", { "blade" })
		require("luasnip").filetype_extend("php", { "phpdoc" })
		require("luasnip").filetype_extend("typescript", { "tsdoc" })
		require("luasnip").filetype_extend("javascript", { "jsdoc" })
	end,
}
