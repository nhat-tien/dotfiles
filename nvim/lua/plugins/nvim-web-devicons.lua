return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	config = function()
		require("nvim-web-devicons").set_icon({
			php = {
				icon = "󰌟",
				color = "#a074c4",
				cterm_color = "140",
				name = "Php",
			},
			["ts"] = {
				icon = "󰛦",
				color = "#519aba",
				cterm_color = "74",
				name = "TypeScript",
			},
		})
	end,
}
