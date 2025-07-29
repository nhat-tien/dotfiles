return {
   'esmuellert/nvim-eslint',
   cond = function ()
      return vim.fn.isdirectory(vim.fn.finddir("node_modules", vim.fn.getcwd() .. ";")) ~= 0
   end,
   config = function ()
      require('nvim-eslint').setup({})
   end
}
