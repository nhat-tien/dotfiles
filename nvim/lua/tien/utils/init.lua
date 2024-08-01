local M = {}

M.handleURL = function()
   -- "%" is escape charater in lua :)))
  local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;)%]]*")
  if url ~= "" then
    vim.cmd('exec "!open \'' .. url .. '\'"')
  else
    vim.cmd('echo "No URI found in line."')
  end
end

return M
