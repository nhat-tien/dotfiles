local M = {}
M.isNeed = function (langName)
   local lang = require("config.lang").plugins
   return vim.list_contains(lang, langName);
end
return M
