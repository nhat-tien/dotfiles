local wezterm = require "wezterm"

local config = {}
config.font_size = 10
config.font = wezterm.font_with_fallback({
    { family = "CaskaydiaCove Nerd Font", scale = 1.5},
  });
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "CaskaydiaCove Nerd Font", weight = "Bold", scale = 1.5}
    }),
  },

  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font_with_fallback({
      { family = 'CaskaydiaCove Nerd Font', weight = "Regular", style = "Italic", scale = 1.5}
    }),
   },

}

config.allow_square_glyphs_to_overflow_width = "Never"
config.color_scheme = 'Tokyo Night Storm'
config.window_background_opacity = 0.7
config.enable_tab_bar = false

config.keys = {
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(-1)
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(1)
  },
  {
    key = '-',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DecreaseFontSize
  },
  {
    key = '+',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.IncreaseFontSize
  },
}
return config;

