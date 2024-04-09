return {
	"Exafunction/codeium.vim",
	lazy = true,
	cmd = "CodeiumEnable",
	-- ft = {
	--    "python",
	-- },
	config = function()
		local opts = { expr = true, silent = true }
		-- Change '<C-g>' here to any keycode you like.
		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, opts)
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, opts)
		-- vim.keymap.set("i", "<c-,>", function()
		-- 	return vim.fn["codeium#CycleCompletions"](-1)
		-- end, opts)
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, opts)
		print("AI bot is starting ~(> ▽ <)~")
	end,
}
