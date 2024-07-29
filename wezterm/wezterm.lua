local wezterm = require "wezterm"

local config = {}

config.font_size = 11
config.font = wezterm.font_with_fallback({
    { family = "CaskaydiaCove Nerd Font", scale = 1, weight = "DemiBold"},
  });

config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "CaskaydiaCove Nerd Font", weight = "Bold", scale = 1}
    }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font_with_fallback({
      { family = 'CaskaydiaCove Nerd Font', weight = "Bold", style = "Italic", scale = 1}
    }),
  },
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font_with_fallback({
      { family = 'CaskaydiaCove Nerd Font', weight = "Regular", style = "Italic", scale = 1}
    }),
   },

}

config.allow_square_glyphs_to_overflow_width = "Never"
config.line_height = 1.15
config.custom_block_glyphs = true
config.color_scheme = 'Tokyo Night Moon'
config.window_background_opacity = 0.9
config.enable_tab_bar = false
config.xim_im_name = 'ibus'
config.disable_default_key_bindings = false
config.underline_thickness = 2

-- config.front_end = "WebGpu"
config.webgpu_preferred_adapter = {
   backend = "Vulkan",
   device_type = "Cpu",
   name = "llvmpipe (LLVM 15.0.7, 256 bits)"
}

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

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
    key = '_',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DecreaseFontSize
  },
  {
    key = '+',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.IncreaseFontSize
  },
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnWindow ,
  },
}
config.warn_about_missing_glyphs = false
return config;
