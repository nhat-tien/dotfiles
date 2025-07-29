return {
	"lewis6991/gitsigns.nvim",
   event = "BufReadPre",
   cond = function ()
      return vim.fn.isdirectory(vim.fn.finddir(".git", vim.fn.getcwd() .. ";")) ~= 0
   end,
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		})
	end,
}
