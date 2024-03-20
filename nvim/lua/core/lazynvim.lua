local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	--  ==== Lsp and Completion ====
	{
		"neovim/nvim-lspconfig",
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	-- ==============================
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			local config = require("plugins.comment")
			require("Comment").setup(config)
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "BufEnter",
		config = function()
			local config = require("plugins.mini-surround")
			require("mini.surround").setup(config)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		ft = {
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"php",
			"vue",
			"markdown",
			"xml",
		},
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		ft = {
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"php",
			"vue",
		},
		config = function()
			require("ts_context_commentstring").setup({})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		ft = {
			"css",
			"toml",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		},
		config = function()
			require("colorizer").setup({
				"css",
				"toml",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- Diagnostic Picker
	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>d",
				function()
					require("trouble").toggle()
				end,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	-- Command suggestion
	{
		"gelguy/wilder.nvim",
		opts = {},
		config = function()
			local wilder = require("wilder")

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlights = {
						border = "Normal", -- highlight to use for the border
					},
					-- 'single', 'double', 'rounded' or 'solid'
					-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
					border = "rounded",
				}))
			)

			wilder.setup({ modes = { ":", "/", "?" } })
		end,
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		-- ft = "markdown",
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/NotesVaults/notes/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/NotesVaults/notes/**.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/NotesVaults/mainVault/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/NotesVaults/mainVault/**.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/NotesVaults/zettel/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/NotesVaults/zettel/**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.obsidian-nvim-config")
		end,
	},
	-- Add icon to lsp completion
	{
		"onsails/lspkind.nvim",
	},
	-- For better lsp experience
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			local config = require("lsp.lspsaga-config")
			require("lspsaga").setup(config)
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- Code snippets shot
	{
		"ellisonleao/carbon-now.nvim",
		lazy = true,
		cmd = "CarbonNow",
		opts = {
			theme = "night owl",
			font_family = "Cascadia Code",
		},
	},
	-- Laravel support
	{
		"adalessa/laravel.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
			"nvimtools/none-ls.nvim",
		},
		cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
		keys = {
			{ "<leader>la", ":Laravel artisan<cr>" },
			{ "<leader>lr", ":Laravel routes<cr>" },
			{ "<leader>lm", ":Laravel related<cr>" },
		},
		-- event = { "VeryLazy" },
		lazy = true,
		config = true,
      opts = {
          commands_options = {
              ["make:model"] = { options = { "-m" } },
         }
      }
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		ft = {
			"dart",
		},
		config = function()
			local config = require("plugins.flutter-config")
			require("flutter-tools").setup(config)
		end,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "BufEnter",
		config = function()
			require("mini.ai").setup()
		end,
	},
	-- Formatter
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					php = { "php_cs_fixer" },
					lua = { "stylua" },
				},
			})
		end,
	},
	-- Move selection
	{
		"echasnovski/mini.move",
		version = "*",
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup({
				blank = {
					enable = false,
				},
			})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/zen-mode.nvim",
		lazy = true,
		cmd = { "ZenMode" },
		opts = {
			window = {
				width = 0.57, -- width will be 85% of the editor width
			},
		},
	},
   {
      "mg979/vim-visual-multi"
   }
})
