---@brief
---
--- https://github.com/sqls-server/sqls
---
--- ```lua
--- vim.lsp.config('sqls', {
---   cmd = {"path/to/command", "-config", "path/to/config.yml"};
---   ...
--- })
--- ```
--- Sqls can be installed via `go install github.com/sqls-server/sqls@latest`. Instructions for compiling Sqls from the source can be found at [sqls-server/sqls](https://github.com/sqls-server/sqls).

---@type vim.lsp.Config

local is_windows = require("utils").is_windows()

local config_path = is_windows and 'D:\\sqls\\config.yml' or '~/sqls/config.yml'

return {
  cmd = {
     'sqls',
     '-config',
     config_path,
  },
  filetypes = { 'sql', 'mysql' },
  root_markers = { 'config.yml' },
  settings = {},
}
