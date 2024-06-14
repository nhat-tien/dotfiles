return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
   config = function ()
     require("dapui").setup()
   end
}
