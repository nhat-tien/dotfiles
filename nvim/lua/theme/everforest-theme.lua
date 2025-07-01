local M = {}

M.dark_theme_setup = function ()
    require("everforest").setup({
      italics = true,
		on_highlights = function(hl,_)
			hl["@markup.strong"] = {
				bold = true,
			}
		end,
    })
	vim.cmd.colorscheme("everforest")
end

M.light_theme_setup = function ()
	vim.cmd.colorscheme("everforest")
end

M.colors = require("everforest.colours").generate_palette({
   colours_override = function(_) end,
}, "dark")

return M

