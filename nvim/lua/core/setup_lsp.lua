vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		-- vim.keymap.set('n', '<Leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		-- vim.keymap.set("n", "<Leader>k", ":Lspsaga hover_doc<cr>", merge(opts, { desc = "Hover Doc" }))
		vim.keymap.set(
			"n",
			"<Leader>k",
			"<cmd>lua vim.lsp.buf.hover()<cr>",
			vim.tbl_deep_extend("keep", opts, { desc = "Hover Doc" })
		)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		-- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		-- vim.keymap.set("n", "<Leader>r", ":Lspsaga rename<cr>", merge(opts, { desc = "Rename" }))
		vim.keymap.set(
			"n",
			"<Leader>r",
			"<cmd>lua require('renamer').rename()<cr>",
			vim.tbl_deep_extend("keep", opts, { desc = "Rename" })
		)
		vim.keymap.set(
			{ "n", "x" },
			"<leader>uf",
			"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
			vim.tbl_deep_extend("keep", opts, { desc = "Format" })
		)
		-- vim.keymap.set('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		-- vim.keymap.set("n", "<Leader>a", "<cmd>Lspsaga code_action<cr>", merge(opts, {desc = "Code Action"}))
		vim.keymap.set(
			"n",
			"<Leader>a",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			vim.tbl_deep_extend("keep", opts, { desc = "Code Action" })
		)
	end,
})

local lsp_list = require("config.language_servers")
vim.lsp.enable(lsp_list)
