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
      dependencies = "nvim-treesitter/nvim-treesitter"
   },
   {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' }
   },
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   { "nvim-tree/nvim-web-devicons", lazy = true },
	--  ==== Lsp and Completion ====
   {
      'neovim/nvim-lspconfig',
   },
   {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function ()
         require("luasnip.loaders.from_vscode").lazy_load()
      end
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
      'numToStr/Comment.nvim',
      lazy = false,
      config = function ()
         local config = require("plugins.comment")
         require('Comment').setup(config)
      end
   },
   {
      'echasnovski/mini.pairs',
      version = '*',
      event = 'InsertEnter',
      config = function ()
        require('mini.pairs').setup()
      end
   },
   {
      'echasnovski/mini.surround',
      version = '*',
      event = 'BufEnter',
      config = function ()
         local config = require("plugins.mini-surround")
         require('mini.surround').setup(config)
      end
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
      config = function ()
         require('nvim-ts-autotag').setup()
      end
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
      config = function ()
         require('ts_context_commentstring').setup {}
      end
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
      config = function ()
         require('colorizer').setup {
            "css";
            "toml";
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
         }
      end
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
      config = function ()
         require("ibl").setup({
            scope = {
               enabled = false,
            }
         })
      end
   },
   {
      "lewis6991/gitsigns.nvim",
      config = function ()
         require('gitsigns').setup()
      end
   },
   -- Diagnostic Picker 
   {
      "folke/trouble.nvim",
      keys = {
         { "<leader>d", function() require("trouble").toggle() end}
      },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {},
   },
   -- Command suggestion
   {
      'gelguy/wilder.nvim',
      opts = {},
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
        "nvim-neorg/neorg",
        dependencies = { "nvim-lua/plenary.nvim" },
        build = ":Neorg sync-parsers",
        -- tag = "*",
        lazy = true, -- enable lazy load
        ft = "norg", -- lazy load on file type
        cmd = "Neorg", -- lazy load on command
        config = function()
          local setup = require("plugins.neorg-config")
          require("neorg").setup(setup)
        end,
   },
   {
      "epwalsh/obsidian.nvim",
      version = "*",  -- recommended, use latest release instead of latest commit
      lazy = true,
      -- ft = "markdown",
      event = {
         "BufReadPre " .. vim.fn.expand "~" .. "/NotesVaults/notes/**.md",
         "BufNewFile " .. vim.fn.expand "~" .. "/NotesVaults/notes/**.md",
         "BufReadPre " .. vim.fn.expand "~" .. "/NotesVaults/mainVault/**.md",
         "BufNewFile " .. vim.fn.expand "~" .. "/NotesVaults/mainVault/**.md",

      },
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
      config = function ()
        require("plugins.obsidian-nvim-config")
      end,
   },
   -- {
   --    'nvimdev/dashboard-nvim',
   --    event = 'VimEnter',
   --    config = function()
   --
   --    require('dashboard').setup {
   --    -- config
   --    }
   --    end,
   --    dependencies = { {'nvim-tree/nvim-web-devicons'}}
   -- },
   -- Add icon to lsp completion 
   {
      "onsails/lspkind.nvim",
   },
   -- For better lsp experience 
   {
      'nvimdev/lspsaga.nvim',
      event = 'LspAttach',
      config = function()
        local config = require("lsp.lspsaga-config")
        require('lspsaga').setup(config)
      end,
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      }
   },
   -- Code snip shot
   {
      "ellisonleao/carbon-now.nvim",
      lazy = true,
      cmd = "CarbonNow",
      opts = {
         theme = "night owl",
         font_family = "Cascadia Code",
      }
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
   },
})