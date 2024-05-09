local k = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

--key map for buffer
k.set('n','<Tab>', ":bnext<CR>", opts)
k.set('n','<S-Tab>',":bprev<CR>", opts)
-- keymap.set('n','<Leader>c',':bd<CR>', opts)
k.set('n','<Leader>n',':enew<CR>', opts)
k.set('n','<Esc>',':noh<CR><Esc>', opts)

-- Redo
k.set('n','U','<C-r>')

-- Select all
k.set('n','sa','gg<S-v>G',opts)

-- Matching bracket
k.set('n','mm','%',opts)

-- Increment/Decrement
k.set('n','+','<C-a>')
k.set('n','-','<C-x>')

-- Window 
k.set('n','<C-w><left>','<C-w><<C-w><')
k.set('n','<C-w><right>','<C-w>><C-w>>')
k.set('n','<C-w><up>','<C-w>+<C-w>+')
k.set('n','<C-w><down>','<C-w>-<C-w>-')

-- Insert mode
k.set('i','<C-s>','<C-o>:w<CR>')

-- Select mode
k.set('x','>','>gv')
k.set('x','<','<gv')

-- Terminal mode
k.set('t', '<esc>', [[<C-\><C-n>]], opts)

-- keymap snippets
-- keymap.set('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")

