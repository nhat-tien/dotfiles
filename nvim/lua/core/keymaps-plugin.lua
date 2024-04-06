local keymap = vim.keymap
local api = vim.api

-- Telescope keymap
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>f", builtin.find_files, {})
keymap.set("n", "<leader>/", builtin.live_grep, {})
-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble keymap
keymap.set("n", "<leader>d", function()
	require("trouble").toggle()
end)
keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)

-- Lspsaga floating terminal
keymap.set("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>")

-- Formating
api.nvim_create_user_command("Format", function(args)
	require("conform").format({ bufnr = args.buf })
end, {})

keymap.set("n", "<leader>c", function()
	require("mini.bufremove").delete()
end)

keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
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

keymap.set({'n', 'x', 'o'}, '<leader>s',  '<Plug>(leap-forward)')
keymap.set({'n', 'x', 'o'}, 'gS',  '<Plug>(leap-backward)')
-- keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
