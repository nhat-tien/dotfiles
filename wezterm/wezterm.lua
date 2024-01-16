local wezterm = require "wezterm"


local config = {
  font = wezterm.font("CaskaydiaCove NFM", {weight="Regular", stretch="Normal", style="Normal"}),
  font_size = 14,
  font_rules = {
    {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font("CaskaydiaCove Nerd Font Mono", {weight="DemiBold", stretch="Normal", style="Normal"})
      },
    {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font("CaskaydiaCove Nerd Font Mono", {weight="DemiLight", stretch="Normal", style="Italic"})
      },
  },
  color_scheme = 'Tokyo Night Storm',
  window_background_opacity = 0.8
}


return config;
