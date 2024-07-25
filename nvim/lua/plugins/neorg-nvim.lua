return {
    "nvim-neorg/neorg",
    lazy = true,
   dependencies = {
      {
         "pysan3/pathlib.nvim",
         lazy = true
      },
      {
         "nvim-neorg/lua-utils.nvim",
         lazy = true
      }
   },
    version = "*",
    ft = {"norg"},
    config = true,
}
