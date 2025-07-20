return {
   "nhat-tien/coerce.nvim",
   keys = {
      { "<leader>uc", mode = { "n", "x", "o" } }
   },
   opts = {},
   config = function()
      require("coerce").setup({
         default_mode_keymap_prefixes = {
            normal_mode = "<leader>uc",
            motion_mode = "<leader>uc",
            visual_mode = "<leader>uc",
         },
      })
   end
}
