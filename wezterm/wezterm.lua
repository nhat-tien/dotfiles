local wezterm = require "wezterm"

local config = {}

config.font_size = 14
config.font = wezterm.font_with_fallback({
    { family = "CaskaydiaCove Nerd Font", scale = 1},
  });
config.color_scheme = 'Tokyo Night Storm'
config.window_background_opacity = 0.9
config.enable_tab_bar = false

return config;
