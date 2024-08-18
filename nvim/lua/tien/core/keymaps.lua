local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local function create_keymap(mode, key, func, desc)
	vim.keymap.set(mode, key, func, vim.tbl_deep_extend("keep", opts, { desc = desc }))
end

local function create_cmd(command, func, desc)
	vim.api.nvim_create_user_command(command, func, { desc = desc })
end

-- [[ -------------------------------------
--             BUFFER
-- ]] -------------------------------------

create_keymap("n", "<Tab>", ":bnext<CR>")
create_keymap("n", "<S-Tab>", ":bprev<CR>")
-- create_keymap('n','<Leader>c',':bd<CR>', opts)
create_keymap("n", "<Leader>n", ":enew<CR>", "New Buffer")
-- Delete buffer
create_keymap("n", "<leader>c", function()
	require("mini.bufremove").delete()
end, "Buffer Remove")

-- [[ -------------------------------------
--             WINDOW 
-- ]] -------------------------------------

create_keymap("n", "<Leader>w<left>", "<C-w><<C-w><", "Resize Window")
create_keymap("n", "<Leader>w<right>", "<C-w>><C-w>>", "Resize Window")
create_keymap("n", "<Leader>w<up>", "<C-w>+<C-w>+", "Resize Window")
create_keymap("n", "<Leader>w<down>", "<C-w>-<C-w>-", "Resize Window")
create_keymap("n", "<Leader>ww", "<C-w>w", "Change Window")
create_keymap("n", "<Leader>wh", "<C-w>h", "Focus Left Window")
create_keymap("n", "<Leader>wl", "<C-w>l", "Foxus Right Window")
create_keymap("n", "<Leader>wj", "<C-w>j", "Foxus Top Window")
create_keymap("n", "<Leader>wk", "<C-w>k", "Foxus Bottom Window")

-- [[ -------------------------------------
--             UTILS
-- ]] -------------------------------------

-- Hide highlight after use search
create_keymap("n", "<Esc>", ":noh<CR><Esc>")
-- Open url link at cursor line
create_keymap("n", "<Leader>uo", require("tien.utils").handleURL, "Open URL")
-- Redo
create_keymap("n", "U", "<C-r>")
-- Select all
create_keymap("n", "sa", "gg<S-v>G", "Select All")
-- Go to matching bracket
create_keymap("n", "mm", "%")
-- Increment/Decrement
create_keymap("n", "+", "<C-a>")
create_keymap("n", "-", "<C-x>")
-- Save shortcut in insert mode
create_keymap("i", "<C-s>", "<C-o>:w<CR>")
create_keymap("i", "qq", "<Esc>")
-- Adjust indent in visual mode
create_keymap("x", ">", ">gv")
create_keymap("x", "<", "<gv")
-- Escape terminal mode
create_keymap("t", "<esc>", [[<C-\><C-n>]])
-- Insert current date 
-- create_keymap('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")
-- Toggle NvimTree 
create_keymap("n", "<Leader>t", ":NvimTreeToggle<CR>", "Folder Tree Toggle")

-- Telescope keymap
create_keymap("n", "<leader>f", function()
	require("telescope.builtin").find_files()
end, "Find Files")

create_keymap("n", "<leader>/", function()
	require("telescope.builtin").live_grep()
end, "Live Grep")

create_keymap("n", "<leader>{", function()
	require("telescope.builtin").lsp_document_symbols()
end, "LSP doc symbols")

-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble keymap
create_keymap("n", "<leader>d", function()
	require("trouble").toggle("diagnostics")
end, "Diagnostics")
create_keymap("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, "Toggle Quickfix")
create_keymap("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, "Toggle Loclist")

-- Lspsaga floating terminal
create_keymap("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>")

-- Formating
create_cmd("Format", function(args)
	require("conform").format({ bufnr = args.buf })
end, "Format")

-- Todo comment
create_keymap("n", "]t", function()
	require("todo-comments").jump_next()
end, "Next todo comment")

create_keymap("n", "[t", function()
	require("todo-comments").jump_prev()
end, "Previous todo comment")

-- Enable ltex-lsp, tools for spell/grammar checking
create_cmd("LtexEnable", function()
	require("lspconfig").ltex.setup({
		settings = {
			ltex = {
				enabled = { "markdown", "latex" },
				language = "en-US",
			},
		},
	})
end, {})

create_cmd("HarperEnable", function ()
   require("lspconfig").harper_ls.setup {
     -- settings = {
     --   ["harper-ls"] = {
     --     linters = {
     --       spell_check = true,
     --       spelled_numbers = false,
     --       an_a = true,
     --       sentence_capitalization = true,
     --       unclosed_quotes = true,
     --       wrong_quotes = false,
     --       long_sentences = true,
     --       repeated_words = true,
     --       spaces = true,
     --       matcher = true,
     --       correct_number_suffix = true,
     --       number_suffix_capitalization = true,
     --       multiple_sequential_pronouns = true
     --     }
     --   }
     -- },
}
end, {})

-- Debug
create_keymap("n", "<leader>gt", function()
	require("dap").toggle_breakpoint()
end, "DAP: toggle_breakpoint")

create_keymap("n", "<leader>gs", function()
	require("dap").continue()
end, "DAP: continue")

create_keymap("n", "<leader>gc", function()
	require("dap").close()
end, "DAP: close")

-- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
-- create_keymap("n", "<leader>Jo", function()
-- 	require("jdtls").organize_imports()
-- end, "[J]ava [O]rganize Imports")
-- -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
-- create_keymap("n", "<leader>Jv", function()
-- 	require("jdtls").extract_variable()
-- end, "[J]ava Extract [V]ariable")
-- -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
-- create_keymap(
-- 	"x",
-- 	"<leader>Jv",
-- 	"<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
-- 	"[J]ava Extract [V]ariable"
-- )
-- -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
-- create_keymap("n", "<leader>JC", function()
-- 	require("jdtls").extract_constant()
-- end, "[J]ava Extract [C]onstant")
-- -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
-- create_keymap(
-- 	"x",
-- 	"<leader>JC",
-- 	"<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
-- 	"[J]ava Extract [C]onstant"
-- )
-- -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
-- create_keymap("n", "<leader>Jt", function()
-- 	require("jdtls").test_nearest_method()
-- end, "[J]ava [T]est Method")
-- -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
-- create_keymap(
-- 	"x",
-- 	"<leader>Jt",
-- 	"<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
-- 	"[J]ava [T]est Method"
-- )
-- -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
-- create_keymap("n", "<leader>JT", function()
-- 	require("jdtls").test_class()
-- end, "[J]ava [T]est Class")
-- -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
-- create_keymap("n", "<leader>Ju", "<Cmd> JdtUpdateConfig<CR>", "[J]ava [U]pdate Config")

-- -- Allow yourself to run JdtCompile as a Vim command
-- vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
-- -- Allow yourself/register to run JdtUpdateConfig as a Vim command
-- vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- -- Allow yourself/register to run JdtBytecode as a Vim command
-- vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
-- -- Allow yourself/register to run JdtShell as a Vim command
-- vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
