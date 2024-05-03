-- Laravel support
return {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvimtools/none-ls.nvim",
	},
	-- cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
   ft = {
      "php",
   },
	keys = {
		{ "<leader>la", ":Laravel artisan<cr>" },
		-- { "<leader>lr", ":Laravel routes<cr>" },
		-- { "<leader>lm", ":Laravel related<cr>" },
	},
	-- event = { "VeryLazy" },
	lazy = true,
	config = true,
	opts = {
		commands_options = {
			["make:model"] = { options = { "-m" } },
		},
	},
}
