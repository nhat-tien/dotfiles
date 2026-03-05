local M = {}

M.dark_theme_setup = function ()
   local is_transparent = true

   if vim.g.is_display_bg then
      is_transparent = false
   end

	require("tokyonight").setup({
		transparent = is_transparent,
      terminal_color = true,
		styles = {
			sidebars = is_transparent and "transparent" or nil,
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
         hl.TelescopeSelection = {
            bg = c.diff.add
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

M.colors = function ()
   return require("tokyonight.colors").setup({ style = "moon" })
end

return M
