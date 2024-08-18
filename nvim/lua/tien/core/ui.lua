require("tien.core.theme")

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
		indicator = {
			style = "none",
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
	},
})

local function codeium_status()
	return vim.api.nvim_call_function("codeium#GetStatusString", {})
end

local function get_word_count()
	return tostring(vim.fn.wordcount().words) .. "w"
end

local function is_markdown()
	return vim.bo.filetype == "markdown"
end

require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = "|",
		-- section_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
            "mode",
            -- separator = { left = "" },
            separator = { left = "" },
            right_padding = 2,
         },
		},
		lualine_b = { "branch", "diagnostics" },
		lualine_z = {
			"location",
			{
				get_word_count,
				cond = is_markdown,
			},
			{
				codeium_status,
				icons_enabled = true,
				icon = "󱚤",
				separator = {
					left = "",
					right = "",
				},
				color = {
					bg = "#1f2335",
					fg = "#a2aace",
				},
			},
		},
	},
	extensions = { "nvim-tree" },
})
