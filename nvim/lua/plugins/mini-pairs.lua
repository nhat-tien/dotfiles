return {
	"echasnovski/mini.pairs",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup({
         mappings = {
            ['|'] = { action = 'closeopen', pair = '||', neigh_pattern = '[^\\].', register = { cr = false } },
         }
      })
	end,
}
