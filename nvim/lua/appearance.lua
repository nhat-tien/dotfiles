require("tokyonight").setup {
    transparent = true,
    styles = {
       sidebars = "transparent",
      floats = "transparent",
    }
}


vim.cmd[[colorscheme tokyonight-storm]]

require("bufferline").setup{}

require('lualine').setup{
  options = {
    theme = 'tokyonight'
  }
}

