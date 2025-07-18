return {
  "ray-x/go.nvim",
   enabled = function ()
      return require("core.setup_lang").isNeed("go")
   end,
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "nvim-treesitter/nvim-treesitter",
  },
   opts = {},
  -- event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
