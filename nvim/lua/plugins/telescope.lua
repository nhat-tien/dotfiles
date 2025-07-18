return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
   -- keys = {
   --    "<leader>-f",
   --    "<leader>-/"
   -- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	config = function()
		-- local trouble = require("trouble.providers.telescope")
		local ignore_these = {
			"yarn%.lock",
			"package%-lock%.json",
			"pnpm%-lock%.yaml",
			"node_modules/.*",
			"generated/graphql%.tsx", -- scoutus project
			"generated%-gql/.*", -- inkd project
			"zsh%-abbr/.*",
			"zsh%-autosuggestions/.*",
			"zsh%-completions/.*",
			"zsh%-syntax%-highlighting/.*",
			".gitkeep",
			".obsidian/.*",
			".obsidian.vimrc",
			"deno%.lock",
			"%.git/.*",
			"%.svg",
			"%.png",
			"%.jpeg",
			"%.jpg",
			"%.ico",
			"%.webp",
			"%.avif",
			"%.heic",
			"%.mp3",
			"%.mp4",
			"%.mkv",
			"%.mov",
			"%.wav",
			"%.flv",
			"%.avi",
			"%.webm",
			"%.ttf",
			"%.otf",
			"%.woff",
			"%.woff2",
			"%.env.*",
			"%.db",
			"%.zip",
			".yarn/.*",
			"graphql%.schema%.json",
			"schema%.json",
			"go%.sum",
			"vendor/.*",
		}

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			},
			defaults = {
				layout_strategy = "horizontal",
				-- layout_config = {
				--   center = { width = 1 }
				--   -- other layout configuration here
				-- },
				-- other defaults configuration here
				-- mappings = {
				--    i = { ["<c-t>"] = trouble.open_with_trouble },
				--    n = { ["<c-t>"] = trouble.open_with_trouble },
				-- },
				file_ignore_patterns = ignore_these,
				layout_config = {
					-- prompt_position = "top",
					prompt_position = "bottom",
					horizontal = {
						mirror = false,
						preview_cutoff = 100,
						preview_width = 0.5,
					},
					vertical = {
						mirror = true,
						preview_cutoff = 0.4,
					},
					flex = {
						flip_columns = 128,
					},
					height = 0.95,
					width = 0.95,
				},
			},
			pickers = {
				-- find_files = { sorting_strategy = "ascending" },
				-- live_grep = { sorting_strategy = "ascending" },
				-- buffers = { sorting_strategy = "ascending" },
				-- help_tags = { sorting_strategy = "ascending" },
				-- lsp_document_symbols = { sorting_strategy = "ascending" },
				find_files = { sorting_strategy = "descending" },
				live_grep = { sorting_strategy = "descending" },
				buffers = { sorting_strategy = "descending" },
				help_tags = { sorting_strategy = "descending" },
				lsp_document_symbols = { sorting_strategy = "descending" },
			},
		})

      require('telescope').load_extension('fzf')
		require("telescope").load_extension("ui-select")
	end,
}
