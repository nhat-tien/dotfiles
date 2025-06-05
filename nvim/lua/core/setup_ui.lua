local config = require("config.theme")
local colors = require("tokyonight.colors").setup({ style = "moon" })
local dark_theme = require("theme.tokyonight").dark_theme_setup
local light_theme = require("theme.tokyonight").light_theme_setup

local mode_color = {
   n = colors.blue,
   i = colors.green,
   v = colors.magenta,
   [''] = colors.magenta,
   V = colors.magenta,
   c = colors.cyan,
   no = colors.red,
   s = colors.orange,
   S = colors.orange,
   [''] = colors.orange,
   ic = colors.yellow,
   R = colors.violet,
   Rv = colors.violet,
   cv = colors.red,
   ce = colors.red,
   r = colors.cyan,
   rm = colors.cyan,
   ['r?'] = colors.cyan,
   ['!'] = colors.red,
   t = colors.red,
}

local icons = {
   n = "󰄛 ",
   i = "󰏫 ",
   v = "󰒉 ",
   [''] = "󰒉 ",
   V = "󰒉 ",
   c = " ",
   no = "",
   s = "",
   S = "",
   [''] = "",
   ic = "",
   R = "",
   Rv = "",
   cv = "",
   ce = "",
   r = "",
   rm = "",
   ['r?'] = "",
   ['!'] = "",
   t = " ",
}

local function autoChangeTheme()
   local hour = tonumber(os.date("%H"))
   if hour >= 6 and hour <= 18 then
      return "light"
   else
      return "dark"
   end
end


local theme = config.auto_mode and autoChangeTheme() or config.mode

if theme == "dark" then
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

require("bufferline").setup({
   options = {
      offsets = {
         {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
         },
      },
      indicator = {
         style = "none",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
         local s = " "
         for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
         end
         return s
      end,
   },
})

local function codeium_status()
   return vim.api.nvim_call_function("codeium#GetStatusString", {})
end

local function get_word_count()
   return tostring(vim.fn.wordcount().words) .. "w"
end

local function is_markdown()
   return vim.bo.filetype == "markdown"
end

require("lualine").setup({
   options = {
      theme = "auto",
      -- component_separators = "|",
      component_separators = "",
      -- section_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
   },
   sections = {
      lualine_a = {
         -- {
         --          "mode",
         --          -- separator = { left = "" },
         --          separator = { left = "" },
         --          right_padding = 2,
         --       },
         {
            "mode",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
            padding = { left = 0 }, -- We don't need space before this

         },
      },
      lualine_b = {
         {
            function()
               return icons[vim.fn.mode()]
            end,
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
         {
            "branch",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
         {
            "diagnostics",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
      },
      lualine_y = {
         {
            "progress",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         }
      },
      lualine_z = {
         {
            "location",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
         {
            get_word_count,
            cond = is_markdown,
         },
         {
            codeium_status,
            icons_enabled = true,
            icon = "󱚤",
            separator = {
               left = "",
               right = "",
            },
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
      },
   },
   extensions = { "nvim-tree" },
})
