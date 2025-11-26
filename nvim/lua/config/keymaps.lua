return {
   opts = { noremap = true, silent = false },
   mapleader = " ",
   maplocalleader = "",
   keymaps = {
      -- [[ -------------------------------------
      --             BUFFER
      -- ]] -------------------------------------
      {
         mode = "n",
         key = "<Tab>",
         fn = ":bnext<CR>",
      },
      {
         mode = "n",
         key = "<S-Tab>",
         fn = ":bprev<CR>",
      },
      {
         mode = "n",
         key = "<leader>n",
         fn = ":enew<CR>",
         desc = "New Buffer",
      },
      {
         mode = "n",
         key = "<leader>c",
         fn = function()
            require("mini.bufremove").delete()
         end,
         desc = "Buffer Remove",
      },
      -- [[ -------------------------------------
      --             WINDOW
      -- ]] -------------------------------------
      {
         mode = "n",
         key = "<leader>wr",
         fn = function()
            require("core.setup_keymap").create_keymap_with_mode({
               escape_key = { mode = "n", key = "<Esc>" },
               keymaps = {
                  {
                     mode = "n",
                     key = { "<Left>", "h" },
                     fn = ":vertical resize +2<CR>",
                     opts = { silent = true, buffer = false }
                  },
                  {
                     mode = "n",
                     key = { "<Right>", "l"},
                     fn = ":vertical resize -2<CR>",
                     opts = { silent = true, buffer = false }
                  },
                  {
                     mode = "n",
                     key = { "<Up>", "k"},
                     fn = ":resize -2<CR>",
                     opts = { silent = true, buffer = false }
                  },
                  {
                     mode = "n",
                     key = { "<Down>", "j"},
                     fn = ":resize +2<CR>",
                     opts = { silent = true, buffer = false }
                  },
               },
            })
         end,
         desc = "Resize Window Mode"
      },
      {
         mode = "n",
         key = "<Leader>ww",
         fn = "<C-w>w",
         desc = "Change Window",
      },
      {
         mode = "n",
         key = "<Leader>wh",
         fn = "<C-w>h",
         desc = "Focus Left Window",
      },
      {
         mode = "n",
         key = "<Leader>wl",
         fn = "<C-w>l",
         desc = "Focus Right Window",
      },
      {
         mode = "n",
         key = "<Leader>wj",
         fn = "<C-w>j",
         desc = "Focus Top Window",
      },
      {
         mode = "n",
         key = "<Leader>wk",
         fn = "<C-w>k",
         desc = "Focus Bottom Window",
      },
      -- [[ -------------------------------------
      --             MISC
      -- ]] -------------------------------------
      {
         mode = "n",
         key = "<Esc>",
         fn = ":noh<CR><Esc>",
         desc = "Hide highlight after using search",
      },
      {
         mode = "n",
         key = "U",
         fn = "<C-r>",
         desc = "Redo",
      },
      {
         mode = "n",
         key = "sa",
         fn = "gg<S-v>G",
         desc = "Select All",
      },
      {
         mode = "n",
         key = "mm",
         fn = "%",
         desc = "Go to matching bracket",
      },
      {
         mode = "n",
         key = "+",
         fn = "<C-a>",
         desc = "Increment",
      },
      {
         mode = "n",
         key = "-",
         fn = "<C-x>",
         desc = "Decrement",
      },
      {
         mode = "n",
         key = "<leader>ub",
         fn = function()
            require("utils").toggle_checkbox()
         end,
         desc = "Toggle checkbox",
      },
      {
         mode = "n",
         key = "<leader>ut",
         fn = "<cmd>Checkmate toggle<CR>",
         desc = "Toggle checkbox",
      },
      {
         mode = "n",
         key = "<leader>uo",
         fn = function()
            require("utils").handleURL()
         end,
         desc = "Open URL",
      },
      {
         mode = "n",
         key = "D",
         fn = '"_d',
         desc = "Delete not cut",
       },
       -- [[ -------------------------------------
       --             UTILS
       -- ]] -------------------------------------
      {
         mode = "n",
         key = "<leader>f",
         fn = function()
            require("telescope.builtin").find_files()
         end,
         desc = "Find Files",
      },
      {
         mode = "n",
         key = "<leader>/",
         fn = function()
            require("telescope.builtin").live_grep()
         end,
         desc = "Live Grep",
      },
      {
         mode = "n",
         key = "<leader>{",
         fn = function()
            require("telescope.builtin").lsp_document_symbols()
         end,
         desc = "LSP doc symbols",
      },
      {
         mode = "n",
         key = "<leader>}",
         fn = function()
            require("telescope.builtin").lsp_document_symbols({ symbols='function' })
         end,
         desc = "Quickfix",
      },
      {
         mode = "n",
         key = "<leader>F",
         fn = function()
            require("telescope.builtin").quickfix()
         end,
         desc = "Quickfix",
      },
      {
         mode = "n",
         key = "<leader>|",
         fn = ":vsplit<CR>",
         desc = "Vertical Split",
      },
      {
         mode = "n",
         key = "<leader>_",
         fn = ":split<CR>",
         desc = "Horizontal Split",
      },
      -- { mode = "n",
      -- 	key = "<leader>t",
      -- 	fn = ":NvimTreeToggle<CR>",
      -- 	desc = "Folder Tree Toggle",
      -- },
      {
         mode = "n",
         key = "<leader>t",
         fn = ":Neotree toggle<CR>",
         desc = "Folder Tree Toggle",
      },
      {
         mode = "n",
         key = "<leader>d",
         fn = function()
            require("trouble").toggle("diagnostics")
         end,
         desc = "Diagnostics",
      },
      {
         mode = "n",
         key = "<leader>xq",
         fn = function()
            require("trouble").toggle("quickfix")
         end,
         desc = "Toggle Quickfix",
      },
      {
         mode = "n",
         key = "<leader>xl",
         fn = function()
            require("trouble").toggle("loclist")
         end,
         desc = "Toggle Loclist",
      },
      {
         mode = "n",
         key = "]t",
         fn = function()
            require("todo-comments").jump_next()
         end,
         desc = "Next todo comment",
      },
      {
         mode = "n",
         key = "[t",
         fn = function()
            require("todo-comments").jump_prev()
         end,
         desc = "Previous todo comment",
      },
      -- *******************************
      -- *             DAP             *
      -- *******************************
      {
         mode = "n",
         key = "<leader>gu",
         fn = function()
            require("dapui").toggle()
         end,
         desc = "DAP-UI: toggle",
      },
      {
         mode = "n",
         key = "<leader>gt",
         fn = function()
            require("dap").toggle_breakpoint()
         end,
         desc = "DAP: toggle_breakpoint",
      },
      {
         mode = "n",
         key = "<leader>gso",
         fn = function()
            require("dap").step_over()
         end,
         desc = "DAP: step_over",
      },
      {
         mode = "n",
         key = "<leader>gsi",
         fn = function()
            require("dap").step_into()
         end,
         desc = "DAP: step_in",
      },
      {
         mode = "n",
         key = "<leader>gsu",
         fn = function()
            require("dap").step_out()
         end,
         desc = "DAP: step_out",
      },
      {
         mode = "n",
         key = "<leader>ga",
         fn = function()
            require("dap").continue()
         end,
         desc = "DAP: continue",
      },
      {
         mode = "n",
         key = "<leader>gc",
         fn = function()
            require("dap").terminate()
         end,
         desc = "DAP: terminate",
      },
      -- [[ -------------------------------------
      --            MACROS
      -- ]] -------------------------------------
      {
         mode = "n",
         key = "<leader>mm",
         fn = 'vi"ms`md"',
         remap = true,
         desc = 'MACROS: " -> `',
      },
      {
         mode = "n",
         key = "<leader>mn",
         fn = "vi'ms`md'",
         remap = true,
         desc = "MACROS: ' -> `",
      },
      {
         mode = "n",
         key = "<leader>p",
         fn = "<C-o>",
         desc = "Go to previous position",
      },
      {
         mode = "n",
         key = "<leader>un",
         fn = "<C-i>",
         desc = "Go to next position",
      },
      {
         mode = "n",
         key = "[t",
         fn = "vit<Esc>`<",
         desc = "Go to start of tag Html",
      },
      {
         mode = "n",
         key = "]t",
         fn = "vit<Esc>`>",
         desc = "Go to end of tag Html",
      },
      {
         mode = "i",
         key = "<C-s>",
         fn = "<C-o>:w<CR>",
         desc = "Save shortcut in insert mode",
      },
      -- {
      -- 	key = "qq",
      -- 	fn = "<Esc>",
      -- 	desc = "Another way to escape insert mode",
      -- },
      {
         mode = "x",
         key = ">",
         fn = ">gv",
         desc = "Adjust indent in visual mode",
      },
      {
         mode = "x",
         key = "<",
         fn = "<gv",
         desc = "Adjust indent in visual mode",
      },
      {
         mode = "x",
         key = "<C-d>",
         fn = '"_d',
         desc = "Delete not cut",
      },
      {
         mode = "t",
         key = "<esc>",
         fn = [[<C-\><C-n>]],
         desc = "Escape terminal mode",
      },
      {
         mode = "x",
         key = "<leader>j",
         fn = function ()
              local util = require("utils")
              util.join_selected_lines()
         end,
         desc = "join line"
      }
   },
   user_command = {
      {
         command = "PrintInBuff",
         fn = function (opts)
            vim.cmd("set nomore")
            vim.cmd("redir @a")
            vim.cmd(opts.args)
            vim.cmd("redir END")
            vim.cmd("set more")
            vim.cmd("new")
            vim.cmd("put a")
         end,
         desc = "Print the result of command to ne buffer",
         opts ={
            nargs = "?",
            complete = "command"
         }
      },
      {
         command = "Format",
         fn = function(args)
            require("conform").format({ bufnr = args.buf })
         end,
         desc = "Format",
      },
      {
         command = "LtexEnable",
         fn = function()
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
         fn = function()
            vim.lsp.enable("harper_ls")
         end,
         desc = "HarperEnable",
      },
      {
         command = "LspInfo",
         fn = function()
            vim.cmd("checkhealth vim.lsp")
         end,
      },
      {
         command = "QfOpenAll",
         fn = ":silent cfdo edit %<CR>"
      },
      {
         command = "Breakline",
         fn = function (opts)
              local util = require("utils")
              local bufnr = vim.api.nvim_get_current_buf()
              local linenr = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-based index
              util.break_line_to_multiline(bufnr, linenr, tonumber(opts.args))
         end,
         opts = {
            nargs = "?"
         }
      },
   },
}
-- [[ -------------------------------------
--             UTILS
-- ]] -------------------------------------

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
