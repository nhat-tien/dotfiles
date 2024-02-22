vim.g.mapleader = ' '

--key map for buffer
vim.keymap.set('n','<Tab>', ":bnext<CR>")
vim.keymap.set('n','<S-Tab>',":bprev<CR>")
vim.keymap.set('n','<Leader>c',':bd<CR>')
vim.keymap.set('n','<Leader>n',':enew<CR>')
vim.keymap.set('n','<Esc>',':noh<CR><Esc>')
vim.keymap.set('n','U','<C-r>')

-- keymap for insert mode
vim.keymap.set('i','<C-s>','<C-o>:w<CR>')
vim.keymap.set('i','<Tab>',' ')

-- keymap snippets
vim.keymap.set('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")

-- NvimTree keymap
vim.keymap.set('n','<Leader>t',':NvimTreeToggle<CR>')

-- Telescope keymap
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Trouble keymap
vim.keymap.set("n", "<leader>d", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
