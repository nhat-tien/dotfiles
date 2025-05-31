local M = {}

M.dark_theme_setup = function ()
	require("tokyonight").setup({
		transparent = true,
      terminal_color = true,
		styles = {
			sidebars = "transparent",
			-- floats = "transparent",
		},
		on_colors = function(colors)
			colors.bg_statusline = colors.none
		end,
		on_highlights = function(hl, c)
			hl["@markup.strong"] = {
				bold = true,
				fg = "#ff9e64",
			}
			hl["@markup.italic"] = {
				italic = true,
				fg = "#e0af68",
			}
         hl.TabLineFill = {
            bg = c.none
         }
		end,
	})

	vim.cmd.colorscheme("tokyonight-moon")
end

M.light_theme_setup = function ()
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

return M
