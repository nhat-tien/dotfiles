-- return {}
return {
	"nvim-java/nvim-java",
   ft = {
     'java'
   },
	config = function()
		require("java").setup({
			jdk = {
				-- install jdk using mason.nvim
				auto_install = false,
			},
		})
    require('lspconfig').jdtls.setup({})
	end,
}
