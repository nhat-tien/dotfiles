return {
   "akinsho/git-conflict.nvim",
   -- cmd = { "GitConflit", },
   cond = function ()
      return vim.fn.isdirectory(vim.fn.finddir(".git", vim.fn.getcwd() .. ";")) ~= 0
   end,
   version = "*",
   opts = {
      -- default_mappings = {
      --    ours = 'co',
      --    theirs = 'ct',
      --    none = 'c0',
      --    both = 'cb',
      --    next = ']x',
      --    prev = '[x',
      -- },
   }
}
