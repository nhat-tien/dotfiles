local M = {}

M.handleURL = function()
   -- "%" is escape charater in lua :)))
  local url = string.match(vim.fn.getline("."), "https*://[^ >,;)%]]*")
  if url ~= "" then
    vim.cmd('exec "!open \'' .. url .. '\' > /dev/null 2>&1"')
  else
    vim.cmd('echo "No URI found in line."')
  end
end

return M
