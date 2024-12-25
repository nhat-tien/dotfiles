return {
	"GustavEikaas/easy-dotnet.nvim",
   enabled = function ()
      return require("tien.core.setuplang").isNeed("csharp")
   end,
   ft = "cs",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		require("easy-dotnet").setup()
	end,
}
