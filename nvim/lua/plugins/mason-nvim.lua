-- return {}
return {
	"mason-org/mason.nvim",
   event = "BufReadPre",
	config = function()
		require("mason").setup()
	end,
}
