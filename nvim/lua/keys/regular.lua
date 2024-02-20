vim.g.mapleader = ' '


-- function MoveBuffer(direction)
--    if vim.fn.expand("%") == "neo-tree filesystem [1]" then
--          vim.cmd([[bnext]])
--          -- vim.cmd([[Neotree toggle]])
--    else
--       if direction == "next" then
--          vim.cmd([[bnext]])
--       elseif direction == "prev" then
--          vim.cmd([[bprev]])
--       end
--    end
-- end

--key map for nvimtree
vim.keymap.set('n','<Leader>t',':Neotree toggle<CR>')

--key map for buffer
vim.keymap.set('n','<Tab>', ":bnext<CR>")
vim.keymap.set('n','<S-Tab>',":bprev<CR>")
vim.keymap.set('n','<Leader>c',':bd<CR>')
vim.keymap.set('n','<Leader>n',':enew<CR>')
vim.keymap.set('n','<Esc>',':noh<CR><Esc>')
vim.keymap.set('n','U','<C-r>')
