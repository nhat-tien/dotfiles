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
	--  ==== Lsp and Completion ====
   {  'neovim/nvim-lspconfig' },
   {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = { "rafamadriz/friendly-snippets" },
   },
	{  'saadparwaiz1/cmp_luasnip' },
	{  'hrsh7th/cmp-nvim-lsp'  },
	{  'hrsh7th/nvim-cmp'  },
	{  'hrsh7th/cmp-path'  },
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
   {  "windwp/nvim-ts-autotag" },
   { "JoosepAlviste/nvim-ts-context-commentstring" },
   { "norcalli/nvim-colorizer.lua" },
   {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-tree/nvim-web-devicons",
         "MunifTanjim/nui.nvim",
      }
   },
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
   }
})
