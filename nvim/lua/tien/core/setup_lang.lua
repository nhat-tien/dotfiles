local M = {}
M.isNeed = function (langName)
   local lang = require("tien.config.lang")
   return vim.list_contains(lang, langName);
end
return M
