return {
   dir = "/home/nhattien/DEV/nvim-plugin/lucgiac.nvim",
   config = function ()
      local opts = { noremap = true, silent = true }

      local function create_keymap(mode, key, func, desc)
         vim.keymap.set(mode, key, func, vim.tbl_deep_extend("keep", opts, { desc = desc }))
      end

      create_keymap("n", "<Leader>Zr", function ()
         require("lucgiac").new_pane("right")
      end, "[Z]ellij new pane [r]ight")

      create_keymap("n", "<Leader>Zd", function ()
         require("lucgiac").new_pane("down")
      end,"[Z]ellij new pane [d]own")

      create_keymap("n", "<Leader>Zf", function ()
         require("lucgiac").new_pane("float")
      end, "[Z]ellij new pane [f]loat")
   end
}
