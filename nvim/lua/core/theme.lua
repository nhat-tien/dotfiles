local auto_theme = false
local theme = "night" -- "night" | "day"

local function autoChangeTheme()
	local hour = tonumber(os.date("%H"))
	if hour >= 6 and hour <= 18 then
		return "day"
	else
		return "night"
	end
end

theme = auto_theme and autoChangeTheme() or theme

if theme == "night" then
	require("tokyonight").setup({
		transparent = true,
		styles = {
			sidebars = "transparent",
			-- floats = "transparent",
		},
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
else
	require("tokyonight").setup({
		on_highlights = function(hl)
			hl["@markup.strong"] = {
				bold = true,
				fg = "#ff9e64",
			}
			hl["@markup.italic"] = {
				italic = true,
				fg = "#e0af68",
			}
			hl.CursorLine = {
				bg = "000000",
			}
		end,
	})

	vim.cmd.colorscheme("tokyonight-day")
end

