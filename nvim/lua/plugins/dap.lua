-- return {}
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	-- lazy = true,
	config = function()
		local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<leader>gt", dap.toggle_breakpoint, {desc = "DAP: toggle_breakpoint"})
		vim.keymap.set("n", "<leader>gs", dap.continue, { desc = "DAP: continue"})
		vim.keymap.set("n", "<leader>gc", dap.close, {})
	end,
}
