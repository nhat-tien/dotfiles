return {
	opts = { noremap = true, silent = true },
	mapleader = " ",
	maplocalleader = ";",
	keymaps = {
		normal = {
			-- [[ -------------------------------------
			--             BUFFER
			-- ]] -------------------------------------
			{
				key = "<Tab>",
				func = ":bnext<CR>",
			},
			{
				key = "<S-Tab>",
				func = ":bprev<CR>",
			},
			{
				key = "<leader>n",
				func = ":enew<CR>",
				desc = "New Buffer",
			},
			{
				key = "<leader>c",
				func = function()
					require("mini.bufremove").delete()
				end,
				desc = "Buffer Remove",
			},
			-- [[ -------------------------------------
			--             WINDOW
			-- ]] -------------------------------------
			{
				key = "<Leader>w<left>",
				func = "<C-w><<C-w><",
				desc = "Resize Window",
			},
			{
				key = "<Leader>w<right>",
				func = "<C-w>><C-w>>",
				desc = "Resize Window",
			},
			{
				key = "<Leader>w<up>",
				func = "<C-w>+<C-w>+",
				desc = "Resize Window",
			},
			{
				key = "<Leader>w<down>",
				func = "<C-w>-<C-w>-",
				desc = "Resize Window",
			},
			{
				key = "<Leader>ww",
				func = "<C-w>w",
				desc = "Change Window",
			},
			{
				key = "<Leader>wh",
				func = "<C-w>h",
				desc = "Focus Left Window",
			},
			{
				key = "<Leader>wl",
				func = "<C-w>l",
				desc = "Focus Right Window",
			},
			{
				key = "<Leader>wj",
				func = "<C-w>j",
				desc = "Focus Top Window",
			},
			{
				key = "<Leader>wk",
				func = "<C-w>k",
				desc = "Focus Bottom Window",
			},
			-- [[ -------------------------------------
			--             MISC
			-- ]] -------------------------------------
			{
				key = "<Esc>",
				func = ":noh<CR><Esc>",
				desc = "Hide highlight after using search",
			},
			{
				key = "U",
				func = "<C-r>",
				desc = "Redo",
			},
			{
				key = "sa",
				func = "gg<S-v>G",
				desc = "Select All",
			},
			{
				key = "mm",
				func = "%",
				desc = "Go to matching bracket",
			},
			{
				key = "+",
				func = "<C-a>",
				desc = "Increment",
			},
			{
				key = "-",
				func = "<C-x>",
				desc = "Decrement",
			},
			{
				key = "<leader>ub",
				func = function()
					require("tien.utils.toogle-checkbox").toggle()
				end,
				desc = "Toggle checkbox",
			},
			{
				key = "<leader>uo",
				func = function()
					require("tien.utils.init").handleURL()
				end,
				desc = "Open URL",
			},
			-- [[ -------------------------------------
			--             UTILS
			-- ]] -------------------------------------
			{
				key = "<leader>f",
				func = function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find Files",
			},
			{
				key = "<leader>/",
				func = function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live Grep",
			},
			{
				key = "<leader>{",
				func = function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "LSP doc symbols",
			},
			{
				key = "<leader>F",
				func = function()
					require("telescope.builtin").quickfix()
				end,
				desc = "Quickfix",
			},
			{
				key = "<leader>|",
				func = ":vsplit<CR>",
				desc = "Vertical Split",
			},
			{
				key = "<leader>-",
				func = ":split<CR>",
				desc = "Horizontal Split",
			},
			{
				key = "<leader>t",
				func = ":NvimTreeToggle<CR>",
				desc = "Folder Tree Toggle",
			},
			{
				key = "<leader>d",
				func = function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Diagnostics",
			},
			{
				key = "<leader>xq",
				func = function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Toggle Quickfix",
			},
			{
				key = "<leader>xl",
				func = function()
					require("trouble").toggle("loclist")
				end,
				desc = "Toggle Loclist",
			},
			{
				key = "]t",
				func = function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				key = "[t",
				func = function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{
				key = "<leader>gt",
				func = function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP: toggle_breakpoint",
			},
			{
				key = "<leader>gs",
				func = function()
					require("dap").continue()
				end,
				desc = "DAP: continue",
			},
			{
				key = "<leader>gc",
				func = function()
					require("dap").close()
				end,
				desc = "DAP: close",
			},
		}, -- \Normal mode
		insert = {
			{
				key = "<C-s>",
				func = "<C-o>:w<CR>",
				desc = "Save shortcut in insert mode",
			},
			{
				key = "qq",
				func = "<Esc>",
				desc = "Another way to escape insert mode",
			},
		}, -- \Insert mode
		visual = {
			{
				key = ">",
				func = ">gv",
				desc = "Adjust indent in visual mode",
			},
			{
				key = "<",
				func = "<gv",
				desc = "Adjust indent in visual mode",
			},
		}, -- \Visual mode
		terminal = {
			{
				key = "<esc>",
				func = [[<C-\><C-n>]],
				desc = "Escape terminal mode",
			},
		}, -- \Terminal mode
	},
	user_command = {
		{
			command = "Format",
			func = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
			desc = "Format",
		},
		{
			command = "LtexEnable",
			func = function()
				require("lspconfig").ltex.setup({
					settings = {
						ltex = {
							enabled = { "markdown", "latex" },
							language = "en-US",
						},
					},
				})
			end,
			desc = "LtexEnable",
		},
		{
			command = "HarperEnable",
			func = function()
				require("lspconfig").harper_ls.setup({
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
				})
			end,
			desc = "LtexEnable",
		},
	},
}

-- [[ -------------------------------------
--             UTILS
-- ]] -------------------------------------

-- Open url link at cursor line

-- Save shortcut in insert mode
--
-- Adjust indent in visual mode
-- Insert current date
-- create_keymap('n','<Leader>sd',":pu=strftime('%Y-%m-%d')<CR>")
-- Toggle NvimTree

-- Telescope keymap

-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})

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
