vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "n"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.cmd[[set clipboard+=unnamedplus]]
vim.cmd[[let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript'] ]]
vim.cmd([[
augroup _typst
autocmd!
autocmd BufRead,BufEnter *.typ set filetype=typst
augroup end
]])
