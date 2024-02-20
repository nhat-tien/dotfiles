local trouble = require("trouble.providers.telescope")

require('telescope').setup({
   defaults = {
      layout_strategy='center',
       -- layout_config = {
       --   vertical = { width = 0.5 }
       --   -- other layout configuration here
       -- },
       -- other defaults configuration here
      mappings = {
         i = { ["<c-t>"] = trouble.open_with_trouble },
         n = { ["<c-t>"] = trouble.open_with_trouble },
      }
   },
   pickers = {
      find_files = { sorting_strategy = 'ascending' },
   },
})
