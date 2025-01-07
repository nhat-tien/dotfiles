local lsp_list = {
	{
		name = "lua_ls",
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		},
	},
	{
		name = "html",
		filetypes = {
			"html",
			"rust",
		},
	},
	{
		name = "cssls",
	},
	{
		name = "ts_ls",
	},
	{
		name = "eslint",
	},
	{
		name = "phpactor",
	},
	{
		name = "pylsp",
	},
	-- {
	-- 	name = "rust_analyzer",
	-- 	settings = {
	-- 		["rust-analyzer"] = {
	-- 			-- Other Settings ...
	-- 			procMacro = {
	-- 				ignored = {
	-- 					leptos_macro = {
	-- 						-- optional: --
	-- 						-- "component",
	-- 						"server",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		name = "marksman",
	},
	-- {
	-- 	name = "jdtls",
	-- 	handlers = {
	-- 		["language/status"] = function(_, result)
	-- 			-- Print or whatever.
	-- 		end,
	-- 		["$/progress"] = function(_, result, ctx)
	-- 			-- disable progress updates.
	-- 		end,
	-- 	},
	-- 	init_options = {
	-- 		bundles = {
	-- 			"/home/nhattien/lsp/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-<version>.jar",
	-- 		},
	-- 	},
	-- },
	{
		name = "gopls",
	},
	-- {
	--    name = "ltex",
	--    settings = {
	--       ltex = {serv
	--          enabled = { "markdown", "latex" },
	--          language = "en-US",
	--       }
	--    }
	-- },
	{
      -- volar@1.8.27
		name = "volar",
		init_options = {
			typescript = {
				tsdk = "/home/nhattien/.npm-packages/lib/node_modules/typescript/lib",
			},
		},
	},
	{
		name = "tailwindcss",
		filetypes = {
			"html",
			"javascriptreact",
			"typescriptreact",
			--   "vue"
		},
		on_attach = function(_, bufnr)
			require("tailwindcss-colors").buf_attach(bufnr)
		end,
	},
	-- {
	-- 	name = "typst_lsp",
	-- 	settings = {
	-- 		exportPdf = "never", -- Choose onType, onSave or never.
	-- 		-- serverPath = "" -- Normally, there is no need to uncomment it.
	-- 	},
	-- },
	-- {
	--    name = "dartls"
	-- },
   {
      name = "csharp_ls"
   },
}

return lsp_list
