local M = {}
M.isNeed = function (langName)
   local lang = require("tien.core.config").setupLang
   return vim.list_contains(lang, langName);
end
return M
