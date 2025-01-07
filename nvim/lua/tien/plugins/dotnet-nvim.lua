return {
	"GustavEikaas/easy-dotnet.nvim",
   enabled = function ()
      return require("tien.core.setuplang").isNeed("csharp")
   end,
   ft = "cs",
	dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
   },
	config = function()
		require("easy-dotnet").setup({
         auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "file_scoped",
          enabled = true
      },
      })
	end,
}
