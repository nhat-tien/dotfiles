return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	ft = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"php",
		"vue",
		"markdown",
		"xml",
      "rust",
      "svelte",
      "razor"
	},
	config = function()
		require("nvim-ts-autotag").setup({
         aliases = {
            ["rust"] = "html",
            ["razor"] = "html",
         }
      })
	end,
}
