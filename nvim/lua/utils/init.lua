local M = {}

M.merge = function (t1, t2)
   if t2 == nil then
      return t1
   end

   for k, v in pairs(t2) do
      t1[k] = v
   end

   return t1
end

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
