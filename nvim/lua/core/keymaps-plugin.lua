local k = vim.keymap
local api = vim.api
local opts = { noremap = true, silent = true }

-- NvimTree keymap
k.set('n','<Leader>t',':NvimTreeToggle<CR>', opts)

-- Telescope keymap
local builtin = require("telescope.builtin")
k.set("n", "<leader>f", builtin.find_files, {desc = "Find Files"})
k.set("n", "<leader>/", builtin.live_grep, { desc = "Live Grep"})
k.set("n", "<leader>{", builtin.lsp_document_symbols, { desc = "LSP doc symbols"})
-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble keymap
k.set("n", "<leader>d", function()
	require("trouble").toggle("diagnostics")
end)
k.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
k.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)

k.set("n", "<leader>c", function()
   require("mini.bufremove").delete()
end)
-- Lspsaga floating terminal
k.set("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>")

-- Formating
api.nvim_create_user_command("Format", function(args)
	require("conform").format({ bufnr = args.buf })
end, {})

k.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

k.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Enable ltex-lsp, tools for spell/grammar checking
api.nvim_create_user_command("LtexEnable", function ()
	require("lspconfig").ltex.setup({
      settings = {
         ltex = {
            enabled = { "markdown", "latex" },
            language = "en-US",
         }
      }
   })
end, {})

-- SPRING BOOT --
    -- -- Allow yourself to run JdtCompile as a Vim command
    -- vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
    -- -- Allow yourself/register to run JdtUpdateConfig as a Vim command
    -- vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    -- -- Allow yourself/register to run JdtBytecode as a Vim command
    -- vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
    -- -- Allow yourself/register to run JdtShell as a Vim command
    -- vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

    -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
    vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "[J]ava [O]rganize Imports" })
    -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
    vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "[J]ava Extract [V]ariable" })
    -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
    vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "[J]ava Extract [V]ariable" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
    vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "[J]ava Extract [C]onstant" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
    vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "[J]ava Extract [C]onstant" })
    -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
    vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "[J]ava [T]est Method" })
    -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
    vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "[J]ava [T]est Method" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
    vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
    -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
    vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })

