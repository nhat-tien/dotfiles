return {
   "gregorias/coerce.nvim",
   tag = 'v4.1.0',
   config = true,
   keys = {
      { "<leader>uc", mode = { "n", "x", "o"} }
   },
   opts = {
      default_mode_keymap_prefixes = {
         normal_mode = "<leader>uc",
         motion_mode = "<leader>uc",
         visual_mode = "<leader>uc",
      },
   }
}
