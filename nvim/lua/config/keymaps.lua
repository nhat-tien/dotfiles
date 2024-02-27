local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

--key map for buffer
keymap.set('n','<Tab>', ":bnext<CR>", opts)
keymap.set('n','<S-Tab>',":bprev<CR>", opts)
keymap.set('n','<Leader>c',':bd<CR>', opts)
keymap.set('n','<Leader>n',':enew<CR>', opts)
keymap.set('n','<Esc>',':noh<CR><Esc>', opts)

-- Redo
keymap.set('n','U','<C-r>')

-- Select all
keymap.set('n','%','gg<S-v>G')

-- Increment/Decrement
keymap.set('n','+','<C-a>')
keymap.set('n','-','<C-x>')

-- Window 
keymap.set('n','<C-w><left>','<C-w><')
keymap.set('n','<C-w><right>','<C-w>>')
keymap.set('n','<C-w><up>','<C-w>+')
keymap.set('n','<C-w><down>','<C-w>-')

-- Insert mode
keymap.set('i','<C-s>','<C-o>:w<CR>')

-- Select mode
keymap.set('x','>','>gv')
keymap.set('x','<','<gv')

-- keymap snippets
keymap.set('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")

-- NvimTree keymap
keymap.set('n','<Leader>t',':NvimTreeToggle<CR>', opts)

-- Telescope keymap
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>f', builtin.find_files, {})
keymap.set('n', '<leader>/', builtin.live_grep, {})
-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Trouble keymap
keymap.set("n", "<leader>d", function() require("trouble").toggle() end)
keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
