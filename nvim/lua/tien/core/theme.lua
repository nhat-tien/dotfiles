local config = require("tien.core.config").theme

local function autoChangeTheme()
	local hour = tonumber(os.date("%H"))
	if hour >= 6 and hour <= 18 then
		return "day"
	else
		return "night"
	end
end

local function dark_tokyonight_setup()
	require("tokyonight").setup({
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_colors = function(colors)
			colors.bg_statusline = colors.none
		end,
		on_highlights = function(hl)
			hl["@markup.strong"] = {
				bold = true,
				fg = "#ff9e64",
			}
			hl["@markup.italic"] = {
				italic = true,
				fg = "#e0af68",
			}
		end,
	})

	vim.cmd.colorscheme("tokyonight-moon")
end

local function light_tokyonight_setup()
	require("tokyonight").setup({
		on_colors = function(colors)
			colors.bg_statusline = colors.none
			colors.bg = "#c2c2c2"
		end,
		on_highlights = function(hl)
			hl["@markup.strong"] = {
				bold = true,
				fg = "#ff9e64",
			}
			hl["@markup.italic"] = {
				italic = true,
				fg = "#e0af68",
			}
		end,
	})

	vim.cmd.colorscheme("tokyonight-day")
end

local theme = config.auto_mode and autoChangeTheme() or config.mode

if theme == "night" then
   dark_tokyonight_setup()
else
   light_tokyonight_setup()
end

vim.api.nvim_create_user_command("ToggleMode", function (_)
   if vim.g.colors_name == "tokyonight-moon" then
      light_tokyonight_setup()
   else
      dark_tokyonight_setup()
   end
end, {})
