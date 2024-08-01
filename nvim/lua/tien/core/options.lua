-- [[ -------------------------------------
--              PRIMARY OPTIONS
-- ]] -------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "n"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.foldenable = false
vim.opt.clipboard = "unnamedplus"

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
-- highlight codeblock in markdown
vim.g.markdown_fenced_languages = {
   "html",
   "python",
   "lua",
   "vim",
   "typescript",
   "javascript",
   "php",
   "yaml",
   "toml",
   "rust",
   "java",
}

-- [[ -------------------------------------
--             FILETYPE
-- ]] -------------------------------------
vim.filetype.add({
   pattern = {
      [".*%.blade%.php"] = "blade",
   },
})

vim.filetype.add({
   pattern = {
      [".*%.norg"] = "norg",
   },
})

--
-- [[ -------------------------------------
--             TABLE-MODE
-- ]] -------------------------------------
vim.g.table_mode_disable_mappings = 1
vim.g.table_mode_disable_tableize_mappings = 1

-- vim.g.codeium_enabled = false
