local M = {}

local config = {
  templates = {
    css = {
      replacement = "@import '##path##.css';",
      extract_dirs = {
        'css',
        'stylesheets',
      },
    },
    php = {
      replacement = "<?php snippet('##path##') ?>",
      extract_dirs = {
        'snippets',
      },
    },
    lua = {
      replacement = "require('##path##')"
    }
  }
}

local indent = ""

local function unindent_lines(lines)
  -- get spaces from first line
  indent = string.match(lines[1], '^(%s*)')
  local formatted_lines = {}
  -- remove spaces
  for k, v in pairs(lines) do
    formatted_lines[k] = string.gsub(v, '^' .. indent, '')
  end
  return formatted_lines
end

local function write_extraction(filename, pos)
  local lines = vim.fn.getline(pos[1], pos[2])
  local formattet_lines = unindent_lines(lines)
  local path = io.open(filename, 'w')
  io.output(path)
  io.write(table.concat(formattet_lines, "\n"))
  io.close(path)
  print('\nWritten to ' .. filename)
end

local function replace_lines_in_buffer(pos, path)
  local replacement = ""
  local filename, extension = path:match("^(.+)%.(.+)$")

  -- print("Filename: " .. filename)
  -- print("Extension: " .. extension)

  if config.templates[extension] == nil then return end

  -- cut file name at extract_dirs dir
  if config.templates[extension].extract_dirs then
    for _, value in pairs(config.templates[extension].extract_dirs) do
      local _, final = string.find(filename, value)
      if final then
        filename = string.sub(filename, final + 2)
      end
    end
  end

  local replace_template = config.templates[extension].replacement
  if replace_template then
    replacement = indent .. string.gsub(replace_template, '##path##', filename)
    -- replacement = string.gsub(replace_template, '##path##', filename)
  end

  vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[2], false, { replacement })
end

local function exists(name)
  if type(name) ~= "string" then return false end
  return os.rename(name, name) and true or false
end

M.setup = function(opts)
   config = vim.tbl_deep_extend("force", config, opts or {})
end

M.run = function(pos)
  local filename = vim.fn.input({ prompt = "Enter a path for extraction: ", completion = "dir" })

  if filename == nil or filename == '' then
    print('Please enter a filepath')
    return
  end

  local dir = vim.api.nvim_call_function('fnamemodify', { filename, ':h' })
  if not exists(dir) then
    print(' Directory does not exist')
    return
  end

  write_extraction(filename, pos)
  replace_lines_in_buffer(pos, filename)
end

-- vim.print(
--   replace_lines_in_buffer(1, 'www/assets/css/subdir/test.css'),
--   replace_lines_in_buffer(1, 'www/assets/stylesheets/test.css'),
--   replace_lines_in_buffer(1, 'www/site/snippets/subdir/test.php')
-- )

return M
