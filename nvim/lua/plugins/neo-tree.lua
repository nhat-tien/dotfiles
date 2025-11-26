return {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
   },
   enabled = true,
   lazy = false,
   config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('neo-tree').setup({
         filesystem = {
            window = {
               mappings = {
                  -- Make the mapping anything you want
                  ["N"] = "easy",
               },
            },
            commands = {
               ["easy"] = function(state)
                  local node = state.tree:get_node()
                  local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
                  require("easy-dotnet").create_new_item(path, function()
                     require("neo-tree.sources.manager").refresh(state.name)
                  end)
               end,
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
                        vim.fn.system { "gio", "trash", vim.fn.fnameescape(node.path) }
                     end
                     require("neo-tree.sources.manager").refresh(state.name)
                  end)
               end,
            },
            filtered_items = {
               visible = false,                       -- when true, they will just be displayed differently than normal items
               force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
               children_inherit_highlights = true,    -- whether children of filtered parents should inherit their parent's highlight group
               show_hidden_count = true,              -- when true, the number of hidden items in each folder will be shown as the last entry
               hide_dotfiles = true,
               hide_gitignored = true,
               hide_hidden = true, -- only works on Windows for hidden files/directories
               hide_by_name = {
                  ".DS_Store",
                  "thumbs.db",
                  "__pycache__"
                  --"node_modules",
               },
               hide_by_pattern = { -- uses glob style patterns
                  --"*.meta",
                  --"*/src/*/tsconfig.json"
                  "*lock*"
               },
               always_show = { -- remains visible even if other settings would normally hide it
                  ".gitignore",
                  ".github"
               },
               always_show_by_pattern = { -- uses glob style patterns
                  ".env*",
               },
               never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                  --".DS_Store",
                  --"thumbs.db"
               },
               never_show_by_pattern = { -- uses glob style patterns
                  --".null-ls_*",
               },
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
            },
         },
      })
   end
}
