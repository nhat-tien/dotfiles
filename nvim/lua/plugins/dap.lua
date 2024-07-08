-- return {}
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	-- lazy = true,
	config = function()
		local dap, dapui = require("dap"), require("dapui")

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
--       dap.adapters.gdb = {
--         type = "executable",
--         command = "gdb",
--         args = { "-i", "dap" }
--       }
--       dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "gdb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/src/', 'file')
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtBeginningOfMainSubprogram = false,
--   },
-- }
		vim.keymap.set("n", "<leader>gt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>gc", dap.continue, {})
	end,
}
