return {
  'stevearc/oil.nvim',
  opts = {},
   keys = {
		{ "<leader>-", "<CMD>Oil<CR>", desc = "Open parent directory" },
   },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
config = function ()
   require("oil").setup()
end
}
