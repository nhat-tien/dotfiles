return { 
   'nvim-telescope/telescope-fzf-native.nvim', 
   enabled = function () 
      local os_name = vim.loop.os_uname().sysname
      return os_name == "Linux" 
   end,
   build = 'make' 
}

