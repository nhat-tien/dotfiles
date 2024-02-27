local trouble = require("trouble.providers.telescope")

local ignore_these = {
  'yarn%.lock',
  'package%-lock%.json',
  'pnpm%-lock%.yaml',
  'node_modules/.*',
  'generated/graphql%.tsx', -- scoutus project
  'generated%-gql/.*', -- inkd project
  'zsh%-abbr/.*',
  'zsh%-autosuggestions/.*',
  'zsh%-completions/.*',
  'zsh%-syntax%-highlighting/.*',
  '.gitkeep',
  '.obsidian/.*',
  '.obsidian.vimrc',
  'deno%.lock',
  '%.git/.*',
  '%.svg',
  '%.png',
  '%.jpeg',
  '%.jpg',
  '%.ico',
  '%.webp',
  '%.avif',
  '%.heic',
  '%.mp3',
  '%.mp4',
  '%.mkv',
  '%.mov',
  '%.wav',
  '%.flv',
  '%.avi',
  '%.webm',
  '%.ttf',
  '%.otf',
  '%.woff',
  '%.woff2',
  '%.env.*',
  '%.db',
  '%.zip',
  '.yarn/.*',
  'graphql%.schema%.json',
  'schema%.json',
  'go%.sum',
}

require('telescope').setup({
   defaults = {
       layout_strategy='horizontal',
       -- layout_config = {
       --   center = { width = 1 }
       --   -- other layout configuration here
       -- },
       -- other defaults configuration here
      mappings = {
         i = { ["<c-t>"] = trouble.open_with_trouble },
         n = { ["<c-t>"] = trouble.open_with_trouble },
      },
      file_ignore_patterns = ignore_these,
      layout_config = {
         prompt_position = 'top',
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
         height = 0.94,
         width = 0.86,
      },
   },
   pickers = {
      find_files = { sorting_strategy = 'ascending' },
      live_grep = { sorting_strategy = 'ascending' },
   },
})
