-- return {}
return {
	"williamboman/mason.nvim",
   dependencies = {
      "williamboman/mason-lspconfig.nvim",
   },
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
       require("mason-lspconfig").setup_handlers {
           -- The first entry (without a key) will be the default handler
           -- and will be called for each installed server that doesn't have
           -- a dedicated handler.
           function (server_name) -- default handler (optional)
               require("lspconfig")[server_name].setup {}
           end,
         }
	end,
}
