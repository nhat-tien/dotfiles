local config = require("tien.config.theme")
local switch = require("tien.utils.init").switch

local function autoChangeTheme()
	local hour = tonumber(os.date("%H"))
	if hour >= 6 and hour <= 18 then
		return "day"
	else
		return "night"
	end
end

local dark_theme
local light_theme

switch(config.theme, {
   ["tokyonight-moon"] = function ()
      dark_theme = require("tien.theme.tokyonight").dark_theme_setup
      light_theme = require("tien.theme.tokyonight").light_theme_setup
   end,
   ["default"] = function ()
      dark_theme = require("tien.theme.tokyonight").dark_theme_setup
      light_theme = require("tien.theme.tokyonight").light_theme_setup
   end
})

local theme = config.auto_mode and autoChangeTheme() or config.mode

if theme == "night" then
   dark_theme()
else
   light_theme()
end

vim.api.nvim_create_user_command("ToggleMode", function (_)
   if vim.g.colors_name == "tokyonight-moon" then
      light_theme()
   else
      dark_theme()
   end
end, {})


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
