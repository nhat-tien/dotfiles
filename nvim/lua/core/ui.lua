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
   require("tokyonight").setup {
   transparent = true,
   styles = {
   sidebars = "transparent",
   -- floats = "transparent",
   },
   on_highlights = function(hl)
      hl["@markup.strong"] = {
         bold = true,
         fg = "#ff9e64"
      }
      hl["@markup.italic"] = {
         italic = true,
         fg = "#e0af68"
      }
   end
   }

   vim.cmd.colorscheme "tokyonight-storm"

elseif theme == "day"  then
   require("tokyonight").setup {
      on_highlights = function(hl)
         hl["@markup.strong"] = {
            bold = true,
            fg = "#ff9e64"
         }
         hl["@markup.italic"] = {
            italic = true,
            fg = "#e0af68"
         }
         hl.CursorLine = {
            bg = "000000"
         }
     end
   }

   vim.cmd.colorscheme "tokyonight-day"

end

require("bufferline").setup{
   options = {
      offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true -- use a "true" to enable the default, or set your own character
        }
      },
      indicator = {
         style = 'none'
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
          s = s .. n .. sym
        end
        return s
      end
   }
}

require('lualine').setup{
   options = {
      theme = 'tokyonight',
      component_separators = '|',
      section_separators = { left = '', right = '' },
   },
   sections = {
      lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = { 'branch', 'diagnostics' },
   },
   extensions = {'nvim-tree'}
}

