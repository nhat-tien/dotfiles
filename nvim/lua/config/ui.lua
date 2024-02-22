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

require("bufferline").setup{}

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
   },
}


