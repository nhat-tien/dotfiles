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

vim.cmd([[colorscheme tokyonight-storm]])

require("bufferline").setup{
   options = {
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


