-- [[ -------------------------------------
--              PRIMARY OPTIONS
-- ]] -------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "n"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.foldenable = false

-- [[ -------------------------------------
--             DIAGNOSTIC SIGN
-- ]] -------------------------------------
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

-- [[ -------------------------------------
--            UTILS
-- ]] -------------------------------------
-- use system clipboard
vim.cmd([[set clipboard+=unnamedplus]])
-- highlight codeblock in markdown
vim.cmd([[let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript'] ]])

-- [[ -------------------------------------
--             FILETYPE
-- ]] -------------------------------------
vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

-- vim.g.codeium_enabled = false
