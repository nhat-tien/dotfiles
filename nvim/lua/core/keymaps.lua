local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

--key map for buffer
keymap.set('n','<Tab>', ":bnext<CR>", opts)
keymap.set('n','<S-Tab>',":bprev<CR>", opts)
-- keymap.set('n','<Leader>c',':bd<CR>', opts)
keymap.set('n','<Leader>n',':enew<CR>', opts)
keymap.set('n','<Esc>',':noh<CR><Esc>', opts)

-- Redo
keymap.set('n','U','<C-r>')

-- Select all
keymap.set('n','sa','gg<S-v>G',opts)

-- Matching bracket
keymap.set('n','mm','%',opts)

-- Increment/Decrement
keymap.set('n','+','<C-a>')
keymap.set('n','-','<C-x>')

-- Window 
keymap.set('n','<C-w><left>','<C-w><<C-w><')
keymap.set('n','<C-w><right>','<C-w>><C-w>>')
keymap.set('n','<C-w><up>','<C-w>+<C-w>+')
keymap.set('n','<C-w><down>','<C-w>-<C-w>-')

-- Insert mode
keymap.set('i','<C-s>','<C-o>:w<CR>')

-- Select mode
keymap.set('x','>','>gv')
keymap.set('x','<','<gv')

-- Terminal mode
keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

-- keymap snippets
-- keymap.set('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")

-- NvimTree keymap
keymap.set('n','<Leader>t',':NvimTreeToggle<CR>', opts)


