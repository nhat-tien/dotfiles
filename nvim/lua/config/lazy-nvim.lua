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
   {  'neovim/nvim-lspconfig' },
   {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = { "rafamadriz/friendly-snippets" },
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
   },
   {
      'echasnovski/mini.pairs',
      version = '*'
   },
   {
      'echasnovski/mini.surround',
      version = '*'
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
      opts = function ()
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
      opts = function ()
         require('ts_context_commentstring').setup {}
      end
   },
   {
      "norcalli/nvim-colorizer.lua",
      -- lazy = true,
      -- ft = {
      --    "css",
      --    "toml",
      -- },
   },
   -- {
   --    "nvim-neo-tree/neo-tree.nvim",
   --    branch = "v3.x",
   --    dependencies = {
   --       "nvim-lua/plenary.nvim",
   --       "nvim-tree/nvim-web-devicons",
   --       "MunifTanjim/nui.nvim",
   --    }
   -- },
   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {}
   },
   { "lewis6991/gitsigns.nvim" },
   -- Diagnostic Picker 
   {
      "folke/trouble.nvim",
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
          require("neorg").setup {
            load = {
              ["core.defaults"] = {}, -- Loads default behaviour
              ["core.concealer"] = {}, -- Adds pretty icons to your documents
              ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                  workspaces = {
                    notes = "~/notes",
                  },
                },
              },
            },
          }
        end,
   },
})
