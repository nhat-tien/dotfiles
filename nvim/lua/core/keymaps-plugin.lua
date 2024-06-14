local k = vim.keymap
local api = vim.api
local opts = { noremap = true, silent = true }

-- NvimTree keymap
k.set('n','<Leader>t',':NvimTreeToggle<CR>', opts)

-- Telescope keymap
local builtin = require("telescope.builtin")
k.set("n", "<leader>f", builtin.find_files, {})
k.set("n", "<leader>/", builtin.live_grep, {})
k.set("n", "<leader>{", builtin.lsp_document_symbols, {})
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

k.set("n","<leader>w", function ()
  require("dapui").toggle()
end)
