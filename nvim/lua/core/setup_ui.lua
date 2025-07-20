local config = require("config.theme")
local theme = config.theme
local dark_theme = theme.dark_theme_setup
local light_theme = theme.light_theme_setup

if config.mode == "dark" then
   dark_theme()
else
   light_theme()
end
