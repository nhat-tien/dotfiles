local api = vim.api
local merge = require("utils").merge
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

local function normal_mode(key, func, desc)
	vim.keymap.set("n", key, func, merge(opts, { desc = desc }))
end

local function insert_mode(key, func, desc)
	vim.keymap.set("i", key, func, merge(opts, { desc = desc }))
end

local function select_mode(key, func, desc)
	vim.keymap.set("x", key, func, merge(opts, { desc = desc }))
end

local function terminal_mode(key, func, desc)
	vim.keymap.set("t", key, func, merge(opts, { desc = desc }))
end

-- Key map for buffer
normal_mode("<Tab>", ":bnext<CR>")
normal_mode("<S-Tab>", ":bprev<CR>")
-- keymap.set('n','<Leader>c',':bd<CR>', opts)
normal_mode("<Leader>n", ":enew<CR>", "New Buffer")
normal_mode("<Esc>", ":noh<CR><Esc>")
normal_mode("<Leader>o", function ()
   require("utils").handleURL()
end, "Open URL")

-- Redo
normal_mode("U", "<C-r>")

-- Select all
normal_mode("sa", "gg<S-v>G", "Select All")

-- Matching bracket
normal_mode("mm", "%")

-- Increment/Decrement
normal_mode("+", "<C-a>")
normal_mode("-", "<C-x>")

-- Window
normal_mode("<C-w><left>", "<C-w><<C-w><")
normal_mode("<C-w><right>", "<C-w>><C-w>>")
normal_mode("<C-w><up>", "<C-w>+<C-w>+")
normal_mode("<C-w><down>", "<C-w>-<C-w>-")

-- Insert mode
insert_mode("<C-s>", "<C-o>:w<CR>")

-- Select mode
select_mode(">", ">gv")
select_mode("<", "<gv")

-- Terminal mode
terminal_mode("<esc>", [[<C-\><C-n>]])

-- keymap snippets
-- keymap.set('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")

-- NvimTree keymap
normal_mode("<Leader>t", ":NvimTreeToggle<CR>", "Folder Tree Toggle")

normal_mode("<leader>c", function()
	require("mini.bufremove").delete()
end, "Buffer Remove")

-- Telescope keymap
normal_mode("<leader>f", function()
	require("telescope.builtin").find_files()
end, "Find Files")

normal_mode("<leader>/", function()
	require("telescope.builtin").live_grep()
end, "Live Grep")

normal_mode("<leader>{", function()
	require("telescope.builtin").lsp_document_symbols()
end, "LSP doc symbols")

-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble keymap
normal_mode("<leader>d", function()
	require("trouble").toggle("diagnostics")
end, "Diagnostics")
normal_mode("<leader>xq", function()
	require("trouble").toggle("quickfix")
end, "Toggle Quickfix")
normal_mode("<leader>xl", function()
	require("trouble").toggle("loclist")
end, "Toggle Loclist")

-- Lspsaga floating terminal
normal_mode("<A-t>", "<cmd>Lspsaga term_toggle<CR>")

-- Formating
api.nvim_create_user_command("Format", function(args)
	require("conform").format({ bufnr = args.buf })
end, {})

normal_mode("]t", function()
	require("todo-comments").jump_next()
end, "Next todo comment")

normal_mode("[t", function()
	require("todo-comments").jump_prev()
end, "Previous todo comment")

-- Enable ltex-lsp, tools for spell/grammar checking
api.nvim_create_user_command("LtexEnable", function()
	require("lspconfig").ltex.setup({
		settings = {
			ltex = {
				enabled = { "markdown", "latex" },
				language = "en-US",
			},
		},
	})
end, {})

normal_mode("<leader>gt", function ()
   require("dap").toggle_breakpoint()
end, "DAP: toggle_breakpoint")

normal_mode("<leader>gs", function ()
   require("dap").continue()
end, "DAP: continue")

normal_mode("<leader>gc", function ()
   require("dap").close()
end, "DAP: close")

-- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
normal_mode("<leader>Jo", function()
	require("jdtls").organize_imports()
end, "[J]ava [O]rganize Imports")
-- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
normal_mode("<leader>Jv", function()
	require("jdtls").extract_variable()
end, "[J]ava Extract [V]ariable")
-- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
select_mode("<leader>Jv", "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", "[J]ava Extract [V]ariable")
-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
normal_mode("<leader>JC", function()
	require("jdtls").extract_constant()
end, "[J]ava Extract [C]onstant")
-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
select_mode("<leader>JC", "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", "[J]ava Extract [C]onstant")
-- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
normal_mode("<leader>Jt", function()
	require("jdtls").test_nearest_method()
end, "[J]ava [T]est Method")
-- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
select_mode("<leader>Jt", "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", "[J]ava [T]est Method")
-- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
normal_mode("<leader>JT", function()
	require("jdtls").test_class()
end, "[J]ava [T]est Class")
-- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
normal_mode("<leader>Ju", "<Cmd> JdtUpdateConfig<CR>", "[J]ava [U]pdate Config")

-- SPRING BOOT --
-- -- Allow yourself to run JdtCompile as a Vim command
-- vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
-- -- Allow yourself/register to run JdtUpdateConfig as a Vim command
-- vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- -- Allow yourself/register to run JdtBytecode as a Vim command
-- vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
-- -- Allow yourself/register to run JdtShell as a Vim command
-- vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
