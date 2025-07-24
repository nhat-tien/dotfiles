return {
   opts = { noremap = true, silent = false },
   mapleader = " ",
   maplocalleader = "",
   keymaps = {
      normal = {
         -- [[ -------------------------------------
         --             BUFFER
         -- ]] -------------------------------------
         {
            key = "<Tab>",
            fn = ":bnext<CR>",
         },
         {
            key = "<S-Tab>",
            fn = ":bprev<CR>",
         },
         {
            key = "<leader>n",
            fn = ":enew<CR>",
            desc = "New Buffer",
         },
         {
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
            key = "<leader>wr",
            fn = function()
               local exit_resize_mode = function()
                  vim.keymap.del('n', '<Left>')
                  vim.keymap.del('n', '<Right>')
                  vim.keymap.del('n', '<Up>')
                  vim.keymap.del('n', '<Down>')
                  vim.keymap.del('n', '<Esc>')
                  require("core.setup_keymap").init()
               end
               vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", { silent = true, buffer = false })
               vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", { silent = true, buffer = false })
               vim.keymap.set("n", "<Up>", ":resize -2<CR>", { silent = true, buffer = false })
               vim.keymap.set("n", "<Down>", ":resize +2<CR>", { silent = true, buffer = false })
               vim.keymap.set("n", "<Esc>", function() exit_resize_mode() end, { silent = true, buffer = false })
            end,
         },
         {
            key = "<Leader>ww",
            fn = "<C-w>w",
            desc = "Change Window",
         },
         {
            key = "<Leader>wh",
            fn = "<C-w>h",
            desc = "Focus Left Window",
         },
         {
            key = "<Leader>wl",
            fn = "<C-w>l",
            desc = "Focus Right Window",
         },
         {
            key = "<Leader>wj",
            fn = "<C-w>j",
            desc = "Focus Top Window",
         },
         {
            key = "<Leader>wk",
            fn = "<C-w>k",
            desc = "Focus Bottom Window",
         },
         -- [[ -------------------------------------
         --             MISC
         -- ]] -------------------------------------
         {
            key = "<Esc>",
            fn = ":noh<CR><Esc>",
            desc = "Hide highlight after using search",
         },
         {
            key = "U",
            fn = "<C-r>",
            desc = "Redo",
         },
         {
            key = "sa",
            fn = "gg<S-v>G",
            desc = "Select All",
         },
         {
            key = "mm",
            fn = "%",
            desc = "Go to matching bracket",
         },
         {
            key = "+",
            fn = "<C-a>",
            desc = "Increment",
         },
         {
            key = "-",
            fn = "<C-x>",
            desc = "Decrement",
         },
         {
            key = "<leader>ub",
            fn = function()
               require("utils").toggle_checkbox()
            end,
            desc = "Toggle checkbox",
         },
         {
            key = "<leader>uo",
            fn = function()
               require("utils").handleURL()
            end,
            desc = "Open URL",
         },
         {
            key = "<C-d>",
            fn = '"_d',
            desc = "Delete not cut",
         },
         -- [[ -------------------------------------
         --             UTILS
         -- ]] -------------------------------------
         {
            key = "<leader>f",
            fn = function()
               require("telescope.builtin").find_files()
            end,
            desc = "Find Files",
         },
         {
            key = "<leader>/",
            fn = function()
               require("telescope.builtin").live_grep()
            end,
            desc = "Live Grep",
         },
         {
            key = "<leader>{",
            fn = function()
               require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "LSP doc symbols",
         },
         {
            key = "<leader>F",
            fn = function()
               require("telescope.builtin").quickfix()
            end,
            desc = "Quickfix",
         },
         {
            key = "<leader>|",
            fn = ":vsplit<CR>",
            desc = "Vertical Split",
         },
         {
            key = "<leader>_",
            fn = ":split<CR>",
            desc = "Horizontal Split",
         },
         -- {
         -- 	key = "<leader>t",
         -- 	fn = ":NvimTreeToggle<CR>",
         -- 	desc = "Folder Tree Toggle",
         -- },
         {
            key = "<leader>t",
            fn = ":Neotree toggle<CR>",
            desc = "Folder Tree Toggle",
         },
         {
            key = "<leader>d",
            fn = function()
               require("trouble").toggle("diagnostics")
            end,
            desc = "Diagnostics",
         },
         {
            key = "<leader>xq",
            fn = function()
               require("trouble").toggle("quickfix")
            end,
            desc = "Toggle Quickfix",
         },
         {
            key = "<leader>xl",
            fn = function()
               require("trouble").toggle("loclist")
            end,
            desc = "Toggle Loclist",
         },
         {
            key = "]t",
            fn = function()
               require("todo-comments").jump_next()
            end,
            desc = "Next todo comment",
         },
         {
            key = "[t",
            fn = function()
               require("todo-comments").jump_prev()
            end,
            desc = "Previous todo comment",
         },
         {
            key = "<leader>gt",
            fn = function()
               require("dap").toggle_breakpoint()
            end,
            desc = "DAP: toggle_breakpoint",
         },
         {
            key = "<leader>gs",
            fn = function()
               require("dap").continue()
            end,
            desc = "DAP: continue",
         },
         {
            key = "<leader>gc",
            fn = function()
               require("dap").close()
            end,
            desc = "DAP: close",
         },
         {
            key = "<leader>uf",
            fn = "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
         },
         -- [[ -------------------------------------
         --            MACROS
         -- ]] -------------------------------------
         {
            key = "<leader>mm",
            fn = 'vi"ms`md"',
            remap = true,
            desc = 'MACROS: " -> `',
         },
         {
            key = "<leader>mn",
            fn = "vi'ms`md'",
            remap = true,
            desc = "MACROS: ' -> `",
         },
      }, -- \Normal mode
      insert = {
         {
            key = "<C-s>",
            fn = "<C-o>:w<CR>",
            desc = "Save shortcut in insert mode",
         },
         -- {
         -- 	key = "qq",
         -- 	fn = "<Esc>",
         -- 	desc = "Another way to escape insert mode",
         -- },
      }, -- \Insert mode
      visual = {
         {
            key = ">",
            fn = ">gv",
            desc = "Adjust indent in visual mode",
         },
         {
            key = "<",
            fn = "<gv",
            desc = "Adjust indent in visual mode",
         },
         {
            key = "<C-d>",
            fn = '"_d',
            desc = "Delete not cut",
         },
      }, -- \Visual mode
      terminal = {
         {
            key = "<esc>",
            fn = [[<C-\><C-n>]],
            desc = "Escape terminal mode",
         },
      }, -- \Terminal mode
   },
   user_command = {
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
      }
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
