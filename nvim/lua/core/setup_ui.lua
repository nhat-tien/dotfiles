local config = require("config.theme")
local theme = config.theme
local dark_theme = theme.dark_theme_setup
local light_theme = theme.light_theme_setup

local function autoChangeTheme()
   local hour = tonumber(os.date("%H"))
   if hour >= 6 and hour <= 18 then
      return "light"
   else
      return "dark"
   end
end


local theme_mode = config.auto_mode and autoChangeTheme() or config.mode

if theme_mode == "dark" then
   dark_theme()
else
   light_theme()
end

vim.api.nvim_create_user_command("ToggleMode", function(_)
   if vim.g.colors_name == "tokyonight-moon" then
      light_theme()
   else
      dark_theme()
   end
end, {})
