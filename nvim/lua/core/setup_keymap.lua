local M = {}

function M.create_keymap(keymap_table, opts)

   for _, keymap in pairs(keymap_table) do

      local key_opts = opts

      if keymap.opts ~= nil then
         key_opts = vim.tbl_deep_extend("force", opts, keymap.opts)
      end

      if type(keymap.key) == "table" then
         -- Example:
         --      key = {"h", "<Left>"}
         for _, key in pairs(keymap.key) do
            vim.keymap.set(
               keymap.mode,
               key,
               keymap.fn,
               vim.tbl_deep_extend("force", key_opts, {
                  desc = keymap.desc,
                  remap = keymap.remap,
               })
            )
         end
      else
         vim.keymap.set(
            keymap.mode,
            keymap.key,
            keymap.fn,
            vim.tbl_deep_extend("force", key_opts, {
               desc = keymap.desc,
               remap = keymap.remap,
            })
         )
      end

   end
end

function M.create_user_cmd(keymap_table)
   for _, keymap in pairs(keymap_table) do
      local key_opts = { desc = keymap.desc }
      if keymap.opts ~= nil then
         key_opts = vim.tbl_deep_extend("force", key_opts, keymap.opts)
      end
      vim.api.nvim_create_user_command(keymap.command, keymap.fn, key_opts)
   end
end

function M.create_keymap_with_mode(args)
   local keymap_table = args.keymaps
   local escape_key = args.escape_key
   local exit_resize_mode = function()

      for _, keymap in pairs(keymap_table) do

         if type(keymap.key) == "table" then
           for _, key in pairs(keymap.key) do
               vim.keymap.del(keymap.mode,key)
            end
         else
            vim.keymap.del(keymap.mode,keymap.key)
         end
      end

      vim.keymap.del(escape_key.mode, escape_key.key)
      require("core.setup_keymap").init()
   end
   M.create_keymap(keymap_table, {})
   vim.keymap.set(escape_key.mode, escape_key.key, function() exit_resize_mode() end, escape_key.opts)
end

function M.init()
   local keymaps = require("config.keymaps").keymaps
   local user_command = require("config.keymaps").user_command
   local opts = require("config.keymaps").opts
   local leader = require("config.keymaps").mapleader
   local localleader = require("config.keymaps").maplocalleader
   vim.g.mapleader = leader
   vim.g.maplocalleader = localleader

   M.create_keymap(keymaps, opts)
   M.create_user_cmd(user_command)
end

return M
