local config = require("config.theme")
local theme = config.theme
local dark_theme = theme.dark_theme_setup
local light_theme = theme.light_theme_setup

if config.mode == "dark" then
   dark_theme()
else
   light_theme()
end



-- vim.pack.add({ "https://github.com/neanias/everforest-nvim" })
--
-- require("everforest").setup({
--    italics = true,
--    ---How much of the background should be transparent. 2 will have more UI
--    ---components be transparent (e.g. status line background)
--    transparent_background_level = 2,
--    on_highlights = function(hl, _)
--       hl["@markup.strong"] = {
--          bold = true,
--       }
--    end,
-- })
--
-- vim.cmd.colorscheme("everforest")
