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
         fg = "#ff9e64"
      }
  end
}

vim.cmd([[colorscheme tokyonight-storm]])

require("bufferline").setup{}

require('lualine').setup{
  options = {
    theme = 'tokyonight'
  }
}


