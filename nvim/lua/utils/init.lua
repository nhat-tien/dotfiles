local M = {}

M.handleURL = function()
	-- "%" is escape charater in lua :)))
	local url = string.match(vim.fn.getline("."), 'https*://[^ >,;)%]"]*')
	if url ~= "" then
		vim.cmd("exec \"silent !open '" .. url .. "'\"")
	else
		vim.cmd('echo "No URI found in line."')
	end
end

-- M.openGoogleTranslate = function()
-- 	local vstart = vim.fn.getpos("'<")
--
-- 	local vend = vim.fn.getpos("'>")
--
-- 	local line_start = vstart[2]
-- 	local line_end = vend[2]
--
-- 	-- or use api.nvim_buf_get_lines
-- 	local lines = vim.fn.getline(line_start, line_end)
-- end

M.switch = function (val, case)
   if case[val] then
      case[val]()
   else
      case["default"]()
   end
end

M.toggle_checkbox = require("utils.toogle-checkbox").toggle

return M
