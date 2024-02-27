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
	-- {
	-- 	name = "marksman"
	-- },
	{
		name = "jdtls"
	},
   {
      name = "gopls"
   },
   -- {
   --    name = "ltex",
   --    settings = {
   --       ltex = {
   --          enabled = { "markdown", "latex" },
   --          language = "en-US",
   --       }
   --    }
   -- },
   {
      name = "volar",
      init_options = {
         typescript = {
            tsdk = "/home/nhattien/.npm-packages/lib/node_modules/typescript/lib"
         },
      }
   },
   {
      name = "tailwindcss",
      filetypes = { "html", "javascriptreact","typescriptreact", "vue" }
   },
   {
      name = "typst_lsp",
      settings = {
         exportPdf = "never" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
      }
   },
   {
      name = "dartls"
   }
}

return lsp_list
