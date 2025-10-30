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

M.match = function (val, case)
   if case[val] then
      return case[val]
   else
      return case["default"]
   end
end

M.break_line_to_multiline = function (bufnr, linenr, words_per_line)
   words_per_line = words_per_line or 15
  local line = vim.api.nvim_buf_get_lines(bufnr, linenr, linenr + 1, false)[1]
  if not line then return end

  local words = {}
  for word in line:gmatch("%S+") do
    table.insert(words, word)
  end

  local new_lines = {}
  local current_line = {}
  for _, word in ipairs(words) do
    table.insert(current_line, word)
    if #current_line == words_per_line then
      table.insert(new_lines, table.concat(current_line, " "))
      current_line = {}
    end
  end
  if #current_line > 0 then
    table.insert(new_lines, table.concat(current_line, " "))
  end

  vim.api.nvim_buf_set_lines(bufnr, linenr, linenr + 1, false, new_lines)
end


M.join_selected_lines = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2] - 1
  local end_line = end_pos[2] - 1

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
  if not lines or #lines == 0 then return end

  local joined = table.concat(lines, " "):gsub("%s+", " ")

  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false, { joined })
end


M.toggle_checkbox = require("utils.toogle-checkbox").toggle

return M
