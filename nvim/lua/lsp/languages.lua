local lsp_list = {
	{
		name = "lua_ls",
		settings = {
			Lua = {
			  runtime = {
				version = 'LuaJIT'
			  },
			  diagnostics = {
				globals = {'vim'},
			  },
			  workspace = {
				library = {
				  vim.env.VIMRUNTIME,
				}
			  }
			}
	    }
	},
	{
		name = "html",
	},
	{
		name = "cssls",
	},
    {
		name = "tsserver"
	},
	{
		name = "phpactor"
	},
	{
		name = "pylsp"
	},
	{
		name = "rust_analyzer"
	},
	{
		name = "marksman"
	},
	{
		name = "jdtls"
	}
}

return lsp_list
