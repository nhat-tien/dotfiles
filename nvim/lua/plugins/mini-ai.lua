return {
	"echasnovski/mini.ai",
	version = "*",
	event = "BufEnter",
	config = function()
		require("mini.ai").setup()
	end,
}
