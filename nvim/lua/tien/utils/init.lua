local M = {}

M.handleURL = function()
   -- "%" is escape charater in lua :)))
  local url = string.match(vim.fn.getline("."), "https*://[^ >,;)%]]*")
  if url ~= "" then
    vim.cmd('exec "silent !open \'' .. url .. '\'"')
  else
    vim.cmd('echo "No URI found in line."')
  end
end

return M
