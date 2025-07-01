return {
	"echasnovski/mini.surround",
	version = "*",
   event = "BufReadPre",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "ms", -- Add surrounding in Normal and Visual modes
				delete = "md", -- Delete surrounding
				-- find = 'mm', -- Find surrounding (to the right)
				-- find_left = 'sF', -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "mr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})
	end,
}
