-- return {}
return {
	"nvim-java/nvim-java",
	ft = {
		"java",
	},
	config = function()
		require("java").setup({
			-- load java test plugins
			java_test = {
				enable = false,
			},

			-- load java debugger plugins
			java_debug_adapter = {
				enable = false,
			},

			spring_boot_tools = {
				enable = false,
			},
			jdk = {
				-- install jdk using mason.nvim
				auto_install = false,
			},
		})
		require("lspconfig").jdtls.setup({})
	end,
}
