local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.font_size = 11
config.font = wezterm.font_with_fallback({
	{ family = "CaskaydiaCove Nerd Font", scale = 1, weight = "DemiBold" },
})

config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = "CaskaydiaCove Nerd Font", weight = "Bold", scale = 1 },
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "CaskaydiaCove Nerd Font", weight = "Bold", style = "Italic", scale = 1 },
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "CaskaydiaCove Nerd Font", weight = "Regular", style = "Italic", scale = 1 },
		}),
	},
}


config.freetype_load_flags = 'NO_HINTING'
-- config.freetype_load_target = 'Light'
config.allow_square_glyphs_to_overflow_width = "Never"
config.line_height = 1.15
config.custom_block_glyphs = true
config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = 'Everforest Dark (Gogh)'
config.window_background_opacity = 0.7
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.xim_im_name = "ibus"
config.disable_default_key_bindings = false
config.underline_thickness = 2

-- config.front_end = "WebGpu"
-- config.webgpu_preferred_adapter = {
-- 	backend = "Vulkan",
-- 	device_type = "Cpu",
-- 	name = "llvmpipe (LLVM 15.0.7, 256 bits)",
-- }

config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 0,
}

config.keys = {
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.ScrollByLine(-1),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.ScrollByLine(1),
	},
	{
		key = "-",
		mods = "CTRL|SHIFT",
		action = act.DecreaseFontSize,
	},
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = act.IncreaseFontSize,
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "pane_mode",
			one_shot = true,
		}),
	},
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		{ key = "Escape", action = "PopKeyTable" },
	},
	pane_mode = {
		{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ key = "h", action = act.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },

		{ key = "v", action = act.SplitVertical },
		{ key = "b", action = act.SplitHorizontal },
		{
			key = "x",
			action = act.CloseCurrentPane({ confirm = false }),
		},
	},
}
config.warn_about_missing_glyphs = false

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	config.default_prog = { 'powershell.exe' }
end

return config
