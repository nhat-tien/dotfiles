return {
	"mrcjkb/rustaceanvim",
	version = "^4",
   enabled = function ()
      return require("core.setup_lang").isNeed("rust")
   end,
	ft = "rust",
	config = function()
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						procMacro = {
							ignored = {
								leptos_macro = {
									-- optional: --
									-- "component",
									"server",
								},
							},
						},
					},
				},
			},
		}
	end,
}
