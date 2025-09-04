local dap = require("dap")
local dapui = require("dapui")

dap.adapters.codelldb = {
   id = "codelldb",
   type = "executable",
   command = "/home/nhattien/dap/codelldb-linux-x64/extension/adapter/codelldb",
   -- or if not in $PATH: "/absolute/path/to/codelldb"
   -- On windows you may have to uncomment this:
   -- detached = false,
}

dap.configurations.rust = {
   {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
         return vim.fn.getcwd() ..  '/target/debug/compiler'
      end,
      args = function()
         return { "run", "./example/test.ag" }
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
   },

}
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

require("nvim-dap-virtual-text").setup()
