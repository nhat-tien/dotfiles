vim.g.mapleader = ' '

--key map for nvimtree
vim.keymap.set('n','<Leader>t',':NvimTreeToggle<CR>')

--key map for buffer
vim.keymap.set('n','<Tab>',':bnext<CR>')
vim.keymap.set('n','<S-Tab>',':bprev<CR>')
vim.keymap.set('n','<Leader>c',':bd<CR>')

