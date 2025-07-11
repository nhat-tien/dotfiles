return {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
   },
   lazy = false,
   config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('neo-tree').setup({
         filesystem = {
            commands = {
               delete = function(state)
                  local inputs = require "neo-tree.ui.inputs"
                  local path = state.tree:get_node().path
                  local msg = "Are you sure you want to trash " .. path
                  inputs.confirm(msg, function(confirmed)
                     if not confirmed then return end
                     vim.fn.system({ "gio", "trash", vim.fn.fnameescape(path) })
                     require("neo-tree.sources.manager").refresh(state.name)
                  end)
               end,
               delete_visual = function(state, selected_nodes)
                  local inputs = require("neo-tree.ui.inputs")
                  local count = vim.tbl_count(selected_nodes)
                  local msg = "Are you sure you want to trash " .. count .. " files ?"

                  inputs.confirm(msg, function(confirmed)
                     if not confirmed then return end
                     for _, node in ipairs(selected_nodes) do
                        vim.fn.system {"gio", "trash", vim.fn.fnameescape(node.path) }
                     end
                     require("neo-tree.sources.manager").refresh(state.name)
                  end)
               end,
            },
         },
         window = {
            mappings = {
               ['Y'] = function(state)
                  local node = state.tree:get_node()
                  local filepath = node:get_id()
                  local filename = node.name
                  local modify = vim.fn.fnamemodify
                  local match = require("utils").match

                  local results = {
                     filepath,
                     modify(filepath, ':.'),
                     modify(filepath, ':~'),
                     filename,
                     modify(filename, ':r'),
                     modify(filename, ':e'),
                  }

                  -- absolute path to clipboard
                  -- local i = vim.fn.inputlist({
                  vim.ui.select(
                     { 1, 2, 3, 4, 5, 6 }
                     , {
                        prompt = 'Choose to copy to clipboard:',
                        format_item = function(item)
                           return match(item, {
                              [1] = 'Absolute path: ' .. results[1],
                              [2] = 'Path relative to CWD: ' .. results[2],
                              [3] = 'Path relative to HOME: ' .. results[3],
                              [4] = 'Filename: ' .. results[4],
                              [5] = 'Filename without extension: ' .. results[5],
                              [6] = 'Extension of the filename: ' .. results[6],
                           });
                        end

                     }, function(choice)
                        if choice ~= nil then
                           local result = results[choice]
                           if not result then return print('Invalid choice: ' .. choice) end
                           vim.fn.setreg('+', result)
                           vim.notify('Copied: ' .. result)
                        end
                     end
                  )
               end
            }
         }

      })
   end
}
